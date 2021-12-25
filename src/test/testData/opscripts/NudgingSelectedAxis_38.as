namespace NudgingSelectedAxis {
  vec3[]@ nudgeAxes = {
    vec3(1, 0, 0),
    vec3(0, 1, 0),
    vec3(0, 0, 1)
  };
  uint nudgeAxisIndex = 0;

  vec3 keyToVector(VirtualKey key) {
    vec3 axis = vec3(0, 0, 0);
    vec3 gridSizeMultiple = vec3(32, 8, 32);
    vec3 step = vec3(0, 0, 0);
    if (
      key == Keybindings::GetKey("Left")
      || key == Keybindings::GetKey("Backward")
    ) {
      if (nudgeMode == NudgeMode::Position || nudgeMode == NudgeMode::Pivot) {
        step -= (
            positionNudgeMode == PositionNudgeMode::GridSizeMultiple
            ? gridSizeMultiple
            : vec3(1, 1, 1)
          )
          * settingStepSizePosition;
      } else {
        step -= vec3(1, 1, 1);
      }
    } else if (
      key == Keybindings::GetKey("Right")
      || key == Keybindings::GetKey("Forward")
    ) {
      if (nudgeMode == NudgeMode::Position || nudgeMode == NudgeMode::Pivot) {
        step += (
            positionNudgeMode == PositionNudgeMode::GridSizeMultiple
            ? gridSizeMultiple
            : vec3(1, 1, 1)
          )
          * settingStepSizePosition;
      } else {
        step += vec3(1, 1, 1);
      }
    }

    axis += nudgeAxes[nudgeAxisIndex] * step;
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
    if (VectorsEqual(vector, nudgeAxes[nudgeAxisIndex])) {
      return Keybindings::GetKey("Right");
    } else if (VectorsEqual(vector, nudgeAxes[nudgeAxisIndex] * -1)) {
      return Keybindings::GetKey("Left");
    }
    return nullKey;
  }
}
