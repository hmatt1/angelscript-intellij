class CoordinateSystem {

  vec2 size {
    get const {
      return vec2(60, 60) + vec2(2, 2) * settingCoordinateSystemScale;
    }
  }
  CGameControlCameraEditorOrbital@ Camera { 
    get const {
      auto editor = cast<CGameCtnEditorFree>(GetApp().Editor);
      if (editor is null) return null;
      return editor.OrbitalCameraControl;
    }
  }

  void Render(
    vec2 position,
    bool local,
    float yaw,
    float pitch,
    float roll,
    vec2 tileSize,
    vec3 highlightAxis
  ) {
    vec2 curPos = position;
    float scale = settingCoordinateSystemScale;
    float textMargin = 10;

    nvg::FontFace(font);

    nvg::FontSize(18);
    nvg::FillColor(vec4(0, 0, 0, 1));
    nvg::TextAlign(nvg::Align::Right | nvg::Align::Bottom);
    nvg::Text(
      curPos.x + tileSize.x - 7,
      curPos.y + tileSize.y - 5,
      local ? "Local" : "Global"
    );

    curPos += tileSize / 2;
    vec2 startPos = vec2(curPos);
    nvg::StrokeWidth(2);
    nvg::TextAlign(nvg::Align::Center | nvg::Align::Middle);
    nvg::FontSize(18);
    dictionary[] dirWithColor = {
      {{"dir", vec3(-1, 0, 0)}, {"color", vec4(1, 0, 0, 1)}, {"label", "X"}},
      {{"dir", vec3(0, 1, 0)}, {"color", vec4(0, 0, 1, 1)}, {"label", "Y"}},
      {{"dir", vec3(0, 0, 1)}, {"color", vec4(0, 1, 0, 1)}, {"label", "Z"}}
    };
    for (uint i = 0; i < dirWithColor.Length; i++) {
      vec3 v = vec3(dirWithColor[i]["dir"]);
      if (
        !VectorsEqual(vec3(), highlightAxis)
        && !VectorsEqual(v, highlightAxis)
        && !VectorsEqual(v * -1, highlightAxis)
      ) {
        dirWithColor[i]["color"] = vec4(dirWithColor[i]["color"]) / 2;
      }
      if (local) {
        v = rotateVec3(v, -yaw, -pitch, roll);
      }
      dirWithColor[i]["dir"] = projectVectorToViewingPlane(v) * scale;
    }
    dirWithColor.Sort(function(a, b) {
      return vec3(a["dir"]).z > vec3(b["dir"]).z;
    });
    for (uint i = 0; i < dirWithColor.Length; i++) {
      dictionary dict = dirWithColor[i];
      nvg::StrokeColor(vec4(dict["color"]));
      nvg::FillColor(vec4(dict["color"]));
      nvg::BeginPath();
      nvg::MoveTo(startPos);
      vec3 dir3 = vec3(dict["dir"]);
      vec2 dir2 = vec2(dir3.x, dir3.y);
      curPos = startPos + dir2;
      nvg::LineTo(curPos);
      nvg::ClosePath();
      nvg::Stroke();

      curPos += dir2 / dir2.Length() * textMargin;
      nvg::Text(curPos.x, curPos.y, string(dict["label"]));
    }

  }
}
