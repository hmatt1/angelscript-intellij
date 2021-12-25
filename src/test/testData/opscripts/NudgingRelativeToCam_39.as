namespace NudgingRelativeToCam {
  vec3[] getCoordSystemRelativeToCamera() {
    CGameCtnEditorFree@ editor = GetMapEditor();
    if (editor is null) return {};
    float yaw = editor.OrbitalCameraControl.m_CurrentHAngle;
    if (Math::Abs(Math::ToDeg(yaw)) % 90 == 45.) {
      yaw += Math::ToRad(0.5);
    }

    vec3[] camDirs = {
      vec3(1, 0, 0),
      vec3(0, 1, 0),
      vec3(0, 0, 1)
    };

    // rotate vector so it is relative to the camera
    mat4 m = mat4::Rotate(yaw, vec3(0, 1, 0));
    for (uint i = 0; i < camDirs.Length; i++) {
      camDirs[i] = vecRemoveLastD(m * camDirs[i]);
    }
    
    vec3 gridSize = positionNudgeMode == PositionNudgeMode::GridSizeMultiple
      ? vec3(32, 8, 32)
      : vec3(1, 1, 1);

    vec3[] dirs = {
      vec3(1, 0, 0),
      vec3(-1, 0, 0),
      vec3(0, 1, 0),
      vec3(0, -1, 0),
      vec3(0, 0, 1),
      vec3(0, 0, -1)
    };
    for (uint i = 0; i < dirs.Length; i++) {
      dirs[i] *= gridSize;
      if (nudgeMode == NudgeMode::Pivot || localCoords) {
        dirs[i] = rotateVec3(
          dirs[i],
          cursorYaw,
          cursorPitch,
          cursorRoll
        );
      }
    }

    // compare directions
    uint[] usedDirs;
    uint[] usedCamDirs;
    for (uint i = 0; i < camDirs.Length; i++) {
      uint[] selectedDirIndex = {0, 0, 0};
      float[] camMax = {0, 0, 0};

      for (uint i2 = 0; i2 < camDirs.Length; i2++) {
        if (usedCamDirs.Find(i2) >= 0) continue;

        for (uint i3 = 0; i3 < dirs.Length; i3++) {
          if (usedDirs.Find(i3) >= 0) continue;
          float f = Math::Dot(camDirs[i2], dirs[i3]) / dirs[i3].Length();
          if (f > camMax[i2]) {
            camMax[i2] = f;
            selectedDirIndex[i2] = i3;
          }
        }
      }

      float max = 0;
      uint maxIndex = 0;
      for (uint i2 = 0; i2 < camDirs.Length; i2++) {
        if (camMax[i2] > max) {
          max = camMax[i2];
          maxIndex = i2;
        }
      }

      usedCamDirs.InsertLast(maxIndex);
      usedDirs.InsertLast(selectedDirIndex[maxIndex]);
      usedDirs.InsertLast(
        selectedDirIndex[maxIndex]
        + (selectedDirIndex[maxIndex] % 2 == 0 ? 1 : -1)
      );
      camDirs[maxIndex] = dirs[selectedDirIndex[maxIndex]];
    }
    return camDirs;
  }

  vec3 keyToVector(VirtualKey key) {
    vec3 v;
    VirtualKey[] acceptedKeys = {
      Keybindings::GetKey("Forward"),
      Keybindings::GetKey("Backward"),
      Keybindings::GetKey("Left"),
      Keybindings::GetKey("Right"),
      Keybindings::GetKey("Up"),
      Keybindings::GetKey("Down")
    };
    if (acceptedKeys.Find(key) < 0) {
      return vec3();
    }

    vec3[] coordSystem = getCoordSystemRelativeToCamera();
    if (coordSystem.Length == 0) return vec3();

    vec3 selectedDir = vec3();
    if (key == Keybindings::GetKey("Forward")) {
      selectedDir = nudgeMode == NudgeMode::Rotation
        ? coordSystem[0]
        : coordSystem[2];
    } else if (key == Keybindings::GetKey("Backward")) {
      selectedDir = nudgeMode == NudgeMode::Rotation
        ? coordSystem[0] * -1
        : coordSystem[2] * -1;
    } else if (key == Keybindings::GetKey("Left")) {
      selectedDir = nudgeMode == NudgeMode::Rotation
        ? coordSystem[2] * -1
        : coordSystem[0];
    } else if (key == Keybindings::GetKey("Right")) {
      selectedDir = nudgeMode == NudgeMode::Rotation
        ? coordSystem[2]
        : coordSystem[0] * -1;
    } else if (key == Keybindings::GetKey("Down")) {
      selectedDir = nudgeMode == NudgeMode::Rotation
        ? coordSystem[1]
        : coordSystem[1] * -1;
    } else if (key == Keybindings::GetKey("Up")) {
      selectedDir = nudgeMode == NudgeMode::Rotation
        ? coordSystem[1] * -1
        : coordSystem[1];
    }

    return selectedDir;
  }

  VirtualKey vectorToKey(vec3 vector) {
    vec3[] coordSystem = getCoordSystemRelativeToCamera();
    if (coordSystem.Length == 0) return nullKey;
    vec3[] dirs;
    for (uint i = 0; i < coordSystem.Length; i++) {
      dirs.InsertLast(coordSystem[i]);
      dirs.InsertLast(coordSystem[i] * -1);
    }

    VirtualKey[] keys;
    if (nudgeMode == NudgeMode::Rotation) {
      keys = {
        Keybindings::GetKey("Forward"),
        Keybindings::GetKey("Backward"),
        Keybindings::GetKey("Down"),
        Keybindings::GetKey("Up"),
        Keybindings::GetKey("Right"),
        Keybindings::GetKey("Left")
      };
    } else {
      keys = {
        Keybindings::GetKey("Left"),
        Keybindings::GetKey("Right"),
        Keybindings::GetKey("Up"),
        Keybindings::GetKey("Down"),
        Keybindings::GetKey("Forward"),
        Keybindings::GetKey("Backward")
      };
    }
    for (uint i = 0; i < dirs.Length; i++) {
      if (VectorsEqual(vector, dirs[i] / dirs[i].Length())) {
        return keys[i];
      }
    }
    return nullKey;
  }
}
