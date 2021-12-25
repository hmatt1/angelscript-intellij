vec3 vecRemoveLastD(vec4 v) {
  return vec3(v.x, v.y, v.z);
}

vec2 vecRemoveLastD(vec3 v) {
  return vec2(v.x, v.y);
}

float Angle(vec3 a, vec3 b) {
  float res = Math::Dot(a, b) / (a.Length() * b.Length());
  return Math::Acos(Math::Clamp(res, -1., 1.));
}

vec3 rotateVec3(vec3 v, float yaw, float pitch, float roll) {
  mat4 Ry = mat4::Rotate(yaw, vec3(0, 1, 0));
  mat4 Rz = mat4::Rotate(pitch, vec3(0, 0, 1));
  mat4 Rx = mat4::Rotate(roll, vec3(1, 0, 0));

  mat4 R = Ry * Rz * Rx;
  return vecRemoveLastD(R * v);
}

vec3 projectVectorToViewingPlane(vec3 dir) {
  auto editor = GetMapEditor();
  if (editor is null) return vec3();
  auto Camera = editor.OrbitalCameraControl;
  float yaw = Camera.m_CurrentHAngle;
  float pitch = Camera.m_CurrentVAngle;
  vec3 x = vec3(1, 0, 0);
  vec3 y = vec3(0, 1, 0);
  vec3 z = vec3(0, 0, 1);

  mat4 mYaw = mat4::Rotate(-yaw, y);
  // mat3 m3Yaw = mat3::Rotate(yaw);
  mat4 mPitch = mat4::Rotate(pitch, x);
  vec3 planeNormal = vecRemoveLastD(mYaw * mPitch * z);
  // up in screen coords is negative => * -1
  vec3 planeVertical = vecRemoveLastD(mYaw * mPitch * y) * -1;
  vec3 planeHorizontal = Math::Cross(planeNormal, planeVertical);

  // project dir into viewing plane
  vec3 projected = dir - (planeNormal * Math::Dot(dir, planeNormal));

  // get coordinates in viewing plane
  vec3 dir2D = vec3(
    Math::Dot(projected, planeHorizontal),
    Math::Dot(projected, planeVertical),
    // set depth information
    Math::Dot(dir, planeNormal)
  );

  return dir2D;
}

bool VectorsEqual(vec3 a, vec3 b) {
  return Math::Abs(a.x - b.x) <= epsilon
    && Math::Abs(a.y - b.y) <= epsilon
    && Math::Abs(a.z - b.z) <= epsilon;
}


string vecToString(vec2 vec, int precision = -1) {
  string format = "%f";
  if (precision > -1) {
    format = "%." + precision + "f";
  }
  return "<" 
    + Text::Format(format, vec.x)
    + ", "
    + Text::Format(format, vec.y)
    + ">";
}
string vecToString(vec3 vec, int precision = -1) {
  string format = "%f";
  if (precision > -1) {
    format = "%." + precision + "f";
  }
  return "<" 
    + Text::Format(format, vec.x)
    + ", "
    + Text::Format(format, vec.y)
    + ", "
    + Text::Format(format, vec.z)
    + ">";
}
