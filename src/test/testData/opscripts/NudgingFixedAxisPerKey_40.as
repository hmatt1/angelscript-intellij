namespace NudgingFixedAxisPerKey {
  vec3 keyToVector(VirtualKey key) {
    vec3 axis = vec3(0, 0, 0);
    if (key == Keybindings::GetKey("Left")) {
      if (nudgeMode == NudgeMode::Position || nudgeMode == NudgeMode::Pivot) {
        axis.x -= settingStepSizePosition 
          * (positionNudgeMode == PositionNudgeMode::GridSizeMultiple ? 32 : 1);
      } else {
        axis.x -= 1;
      }
    } else if (key == Keybindings::GetKey("Right")) {
      if (nudgeMode == NudgeMode::Position || nudgeMode == NudgeMode::Pivot) {
        axis.x += settingStepSizePosition 
          * (positionNudgeMode == PositionNudgeMode::GridSizeMultiple ? 32 : 1);
      } else {
        axis.x += 1;
      }
    } else if (key == Keybindings::GetKey("Forward")) {
      if (nudgeMode == NudgeMode::Position || nudgeMode == NudgeMode::Pivot) {
        axis.z += settingStepSizePosition 
          * (positionNudgeMode == PositionNudgeMode::GridSizeMultiple ? 32 : 1);
      } else {
        axis.z += 1;
      }
    } else if (key == Keybindings::GetKey("Backward")) {
      if (nudgeMode == NudgeMode::Position || nudgeMode == NudgeMode::Pivot) {
        axis.z -= settingStepSizePosition 
          * (positionNudgeMode == PositionNudgeMode::GridSizeMultiple ? 32 : 1);
      } else {
        axis.z -= 1;
      }
    } else if (key == Keybindings::GetKey("Down")) {
      if (nudgeMode == NudgeMode::Position || nudgeMode == NudgeMode::Pivot) {
        axis.y -= settingStepSizePosition 
          * (positionNudgeMode == PositionNudgeMode::GridSizeMultiple ? 8 : 1);
      } else {
        axis.y -= 1;
      }
    } else if (key == Keybindings::GetKey("Up")) {
      if (nudgeMode == NudgeMode::Position || nudgeMode == NudgeMode::Pivot) {
        axis.y += settingStepSizePosition 
          * (positionNudgeMode == PositionNudgeMode::GridSizeMultiple ? 8 : 1);
      } else {
        axis.y += 1;
      }
    }

    if (localCoords) {
      axis = rotateVec3(axis, cursorYaw, cursorPitch, cursorRoll);
    }
    return axis;
  }

  VirtualKey vectorToKey(vec3 vector) {
    if (localCoords || nudgeMode == NudgeMode::Pivot) {
      // rotate vector back
      mat4 Ry = mat4::Rotate(-cursorYaw, vec3(0, 1, 0));
      mat4 Rz = mat4::Rotate(-cursorPitch, vec3(0, 0, 1));
      mat4 Rx = mat4::Rotate(-cursorRoll, vec3(1, 0, 0));

      mat4 R = Rx * Rz * Ry;
      vector = vecRemoveLastD(R * vector);
    }
    VirtualKey[] keys = {
      Keybindings::GetKey("Left"),
      Keybindings::GetKey("Right"),
      Keybindings::GetKey("Up"),
      Keybindings::GetKey("Down"),
      Keybindings::GetKey("Forward"),
      Keybindings::GetKey("Backward")
    };
    vec3[] dirs = {
      vec3(-1, 0, 0),
      vec3(1, 0, 0),
      vec3(0, 1, 0),
      vec3(0, -1, 0),
      vec3(0, 0, 1),
      vec3(0, 0, -1)
    };
    for (uint i = 0; i < dirs.Length; i++) {
      if (VectorsEqual(vector, dirs[i])) {
        return keys[i];
      }
    }
    return nullKey;
  }
}
