
CGameCtnEditorFree@ GetMapEditor() {
  return cast<CGameCtnEditorFree>(GetApp().Editor);
}

float[] rotateRotations(
  float yaw,
  float pitch,
  float roll,
  float delta,
  vec3 axis,
  bool local
) {
  // base axes
  vec3 xAxis = vec3(1, 0, 0);
  vec3 yAxis = vec3(0, 1, 0);
  vec3 zAxis = vec3(0, 0, 1);

  // axes in current rotation
  vec3 x = rotateVec3(xAxis, yaw, pitch, roll);
  vec3 y = rotateVec3(yAxis, yaw, pitch, roll);
  vec3 z = rotateVec3(zAxis, yaw, pitch, roll);

  // axes in wanted rotation
  mat4 m = mat4::Rotate(delta, axis);
  vec3 rX = vecRemoveLastD(m * x);
  vec3 rY = vecRemoveLastD(m * y);
  vec3 rZ = vecRemoveLastD(m * z);

  // project rX to xz plane
  vec3 rX_xz = vec3(rX.x, 0, rX.z);
  // yaw = angle between xAxis & projected vec
  float yaw2 = Angle(xAxis, rX_xz) * Sign(rX.z) * -1;
  // pitch = angle between projected vec & rotated vec
  float pitch2 = Angle(rX_xz, rX) * Sign(rX.y);

  m = mat4::Rotate(yaw2, yAxis);
  vec3 zYaw = vecRemoveLastD(m * zAxis);
  // roll = angle between zYaw & rZ
  float roll2 = Angle(zYaw, rZ) * Sign(rZ.y) * -1;

  return {yaw2, pitch2, roll2};
}

float Sign(float f) {
  return f < 0 ? -1. : 1.;
}

string fmt(float f) {
  return Text::Format("%f", f);
}

string virtualKeyToString(VirtualKey key) {
  if (key == VirtualKey(0)) return "";
  string[] parts = tostring(key).Split("::");
  string s = parts[parts.Length - 1];
  if (KeyToIconMap.Exists(s)) {
    s = string(KeyToIconMap[s]);
  }
  return s;
}

string readPluginFile(string filename) {
  IO::FileSource f(filename);
  return f.ReadToEnd();
}

string replaceIcons(string text) {
  string[] iconNames = {
    "LongArrowLeft",
    "LongArrowRight",
    "LongArrowUp",
    "LongArrowDown"
  };
  string[] icons = {
    Icons::LongArrowLeft,
    Icons::LongArrowRight,
    Icons::LongArrowUp,
    Icons::LongArrowDown
  };

  string res = text;
  for (uint i = 0; i < iconNames.Length; i++) {
    res = Regex::Replace(res, "Icons::" + iconNames[i], icons[i]);
  }
  return res;
}

void printUITextOnButtonBaseline(string text) {
  vec2 cursorPos = UI::GetCursorPos();
  UI::SetCursorPos(cursorPos + vec2(0, 4));
  UI::Text(text);
  UI::SameLine();
  cursorPos = UI::GetCursorPos();
  UI::SetCursorPos(cursorPos - vec2(0, 4));
}
