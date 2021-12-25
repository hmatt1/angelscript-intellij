// this does not work as expected
// the dot moves too fast over the screen but then slows down to match the point
// at the screen edge
// I don't know how to fix this

class PivotInMap {

  CGameCtnEditorFree@ Editor {
    get const {
      return cast<CGameCtnEditorFree>(GetApp().Editor);
    }
  }
  CGameControlCameraEditorOrbital@ Camera {
    get const {
      auto editor = cast<CGameCtnEditorFree>(GetApp().Editor);
      if (editor is null) return null;
      return editor.OrbitalCameraControl;
    }
  }
  bool DrawAPIRemoved = false;

  void RenderInterface() {}

  void Render() {

    if (DrawAPIRemoved) return;

    vec3 cursorPos = Editor.Cursor.FreePosInMap;
    // x 762.282 y 8 (18) z 717.491
    // x 772 - 752 | 44.181° - 45.797° => 44.989 => 45° / 960 px = 0.046875 °/px
    // z 712 - 723 | 28.771° - 28.850° => 28.812 ° / 640 px =      0.045019 °/px

    // x 94.576 y 8 (18) z 219.037
    // x 85 - 104 | 43.759° - 43.301° => 43.53 / 800 px =          0.054413 °/px
    // z 214 - 224 | 26.734° - 26.395° => 26.565 / 450 px =        0.059033 °/px

    // x 768 y 8 (408) z 768
    // x 358 - 1178 | 45.707° / 960 px =                           0.047612 °/px
    // z 565 - 998 | 26.908° - 29.899° / 640 px =                  0.046717 °/px

    // ~90° FOV

    vec2 point = projectPosToCamera(vec3(0, 8, 0));

    nvg::BeginPath();
    nvg::FillColor(vec4(1, 0, 0, 0.5));
    nvg::Circle(point, 20);
    nvg::ClosePath();
    nvg::Fill();
  }

  vec2 projectPosToCamera(vec3 pos) {
    // float fovHalf = Math::ToRad(91.4 / 2.);
    float fovHalf = Math::ToRad(90. / 2);

    float yaw = Camera.m_CurrentHAngle;
    float pitch = Camera.m_CurrentVAngle;
    vec3 cameraPos = Camera.Pos;

    vec3 x = vec3(1, 0, 0);
    vec3 y = vec3(0, 1, 0);
    vec3 z = vec3(0, 0, 1);

    mat4 mYaw = mat4::Rotate(yaw, y);
    mat4 mPitch = mat4::Rotate(pitch, x);
    vec3 planeNormal = vecRemoveLastD(mYaw * mPitch * z);
    vec3 planeVertical = vecRemoveLastD(mYaw * mPitch * y);
    vec3 planeHorizontal = Math::Cross(planeNormal, planeVertical);

    vec3 camToPos = pos - cameraPos;
    float horizontalDist = Math::Dot(planeHorizontal, camToPos);
    float verticalDist = Math::Dot(planeVertical, camToPos);
    vec3 camToPosHorizontal = camToPos - (planeVertical * verticalDist);
    vec3 camToPosVertical = camToPos - (planeHorizontal * horizontalDist);

    float horizontalAngle = Angle(planeNormal, camToPosHorizontal);
    float verticalAngle = Angle(planeNormal, camToPosVertical);

    // it seems like
    // the angle grows with sin(x) but we need linear growth
    // but we already have linear growth... I don't understand it


    // print("===================");
    // float dot = Math::Dot(planeNormal, camToPosHorizontal);
    // float len = planeNormal.Length() * camToPosHorizontal.Length();
    // print("horizontal: " + fmt(dot) + " / " + fmt(len) + " = " + fmt(dot / len) + " => " + Math::Acos(dot / len));
    // dot = Math::Dot(planeNormal, camToPosVertical);
    // len = planeNormal.Length() * camToPosVertical.Length();
    // print("vertical: " + fmt(dot) + " / " + fmt(len) + " = " + fmt(dot / len) + " => " + Math::Acos(dot / len));
    // print("horizontalAngle: " + Math::ToDeg(horizontalAngle));
    // print("verticalAngle: " + verticalAngle);
    // print("horizontalAngle / fovHalf: " + horizontalAngle / fovHalf);

    // wrap in try .. catch if Draw gets removed
    try {
      vec2 screenCenter = vec2(Draw::GetWidth(), Draw::GetHeight()) / 2;
      vec2 point = screenCenter
        + vec2(
          growFunc(horizontalAngle / fovHalf) * screenCenter.x * Sign(horizontalDist),
          verticalAngle / fovHalf * screenCenter.x * -Sign(verticalDist)
        );
      // print("point: " + vecToString(point));
      return point;
    } catch {
      DrawAPIRemoved = true;
      return vec2();
    }
  }

  float growFunc(float x) {
    return x; //Math::Sin(x);
  }
}
