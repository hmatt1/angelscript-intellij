funcdef void PCB(bool fromBlockVisualizer);

class BlockVisualizer {

  vec2 size {
    get const {
      return vec2(3.6, 3.6) * settingBlockVisualizerScale;
    }
  }
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

  void Render(
    vec2 position,
    float yaw,
    float pitch,
    float roll,
    PCB@ renderInBetween,
    vec3 pivotPosition,
    vec2 tileSize
  ) {
    vec2 startPos = position + tileSize / 2;
    vec2 curPos = vec2(startPos);
    float scale = settingBlockVisualizerScale;

    // get block size
    CGameCtnBlockInfo@ blockInfo = Editor.CurrentGhostBlockInfo;
    if (blockInfo is null) {
      renderInBetween(true);
      
      nvg::FontFace(font);
      nvg::FontSize(18);
      nvg::FillColor(vec4(0, 0, 0, 1));
      nvg::TextAlign(nvg::Align::Center | nvg::Align::Bottom);
      nvg::Text(curPos.x, curPos.y, "No block");
      nvg::TextAlign(nvg::Align::Center | nvg::Align::Top);
      nvg::Text(curPos.x, curPos.y, "selected");
      return;
    }

    nat3[] sizes;

    if (blockInfo.VariantGround !is null) {
      sizes.InsertLast(blockInfo.VariantGround.Size);
    }
    if (blockInfo.VariantAir !is null) {
      addUniqueSize(sizes, blockInfo.VariantAir.Size);
    }
    if (blockInfo.VariantBaseGround !is null) {
      addUniqueSize(sizes, blockInfo.VariantBaseGround.Size);
    }
    if (blockInfo.VariantBaseAir !is null) {
      addUniqueSize(sizes, blockInfo.VariantBaseAir.Size);
    }
    for (uint i = 0; i < blockInfo.AdditionalVariantsGround.Length; i++) {
      addUniqueSize(sizes, blockInfo.AdditionalVariantsGround[i].Size);
    }
    for (uint i = 0; i < blockInfo.AdditionalVariantsAir.Length; i++) {
      addUniqueSize(sizes, blockInfo.AdditionalVariantsAir[i].Size);
    }

    // assume there is only one block size
    vec3 blockSize = vec3(sizes[0].x, sizes[0].y, sizes[0].z);
    float maxBlockSize = Math::Max(blockSize.x, Math::Max(blockSize.y, blockSize.z));
    // normalize to 1
    blockSize /= maxBlockSize;

    // rotate the axes
    vec3[] cardinalDirs = {
      vec3(-1, 0, 0),
      vec3(0, 1, 0),
      vec3(0, 0, 1)
    };
    vec3[] corners = {
      vec3(0, 0, 0),
      vec3(-1, 1, 0),
      vec3(-1, 0, 1),
      vec3(0, 1, 1),
      vec3(-1, 1, 1)
    };
    vec3[] extraPoints = {
      // center, pointing from center to origin
      vec3(0.5, -0.5, -0.5),
      // real center to determine rendering order with the
      // coordinate system
      vec3(-0.5, 0.5, 0.5),
      vec3(pivotPosition) / (vec3(32, -8, -32) * maxBlockSize)
    };
    // use handles to fill in the vectors into the original arrays
    vec3[]@[] arrs = {@cardinalDirs, @corners, @extraPoints};
    for (uint i = 0; i < arrs.Length; i++) {
      vec3[]@ arr = @arrs[i];
      for (uint i2 = 0; i2 < arr.Length; i2++) {
        arr[i2] = projectVectorToViewingPlane(
          rotateVec3(arr[i2] * blockSize, -yaw, -pitch, roll)
        ) * scale;
      }
    }
    vec3 center = extraPoints[0];
    vec3 realCenter = extraPoints[1];
    pivotPosition = extraPoints[2];
    
    vec3 maxCorner = vec3(0, 0, -1000);
    // we cant ignore the center because it points from the center to the
    // origin, so it isn't really at the center but mirrored at the origin
    // and therefore outside of the cube
    corners.InsertAt(0, cardinalDirs);
    for (uint i = 0; i < corners.Length; i++) {
      if (corners[i].z > maxCorner.z) {
        maxCorner = corners[i];
      }
    }

    // construct the edges
    //      ___________
    //     /|    11   /|
    //  10/ |      12/ |
    //   /_________y/  |8
    //  |  7|  9   |   |
    //  |   |______|___|z
    // 6|  /   3   |5 /
    //  | /2       | /4
    // x|/_________|/
    //        1    ^
    // start, then clockwise for each layer
    // x: 1, 3, 9, 11
    // y: 5, 6, 7, 8
    // z: 2, 4, 10, 12
    vec3 x = cardinalDirs[0];
    vec3 y = cardinalDirs[1];
    vec3 z = cardinalDirs[2];
    vec3 zero = vec3(0, 0, 0);
    // {move to, line to}
    vec3[][] edges = {
      {zero, x},
      {x, z},
      {z, x},
      {zero, z},
      {zero, y},
      {x, y},
      {x + z, y},
      {z, y},
      {zero + y, x},
      {x + y, z},
      {z + y, x},
      {zero + y, z}
    };

    if (settingBlockVisualizerRelativePosition != BlockVisualizerPosition::Center) {
      DrawPivot(startPos);
    }

    nvg::StrokeColor(vec4(0, 0, 0, 0.2));
    for (uint i = 0; i < edges.Length; i++) {
      vec3[] edge = edges[i];
      if (
        VectorsEqual(edge[0], maxCorner)
        || VectorsEqual(edge[0] + edge[1], maxCorner)
      ) {
        // draw the hidden edges transparent
        DrawEdge(startPos, pivotPosition, edge);
      }
    }

    nvg::StrokeColor(vec4(0, 0, 0, 1));
    for (uint i = 0; i < edges.Length; i++) {
      vec3[] edge = edges[i];
      if (
        !VectorsEqual(edge[0], maxCorner)
        && !VectorsEqual(edge[0] + edge[1], maxCorner)
        && (edge[0] + edge[1]).z > pivotPosition.z - 0.12 * scale
      ) {
        // draw foreground edges solid
        DrawEdge(startPos, pivotPosition, edge);
      }
    }

    renderInBetween(true);

    nvg::StrokeColor(vec4(0, 0, 0, 1));
    for (uint i = 0; i < edges.Length; i++) {
      vec3[] edge = edges[i];
      if (
        !VectorsEqual(edge[0], maxCorner)
        && !VectorsEqual(edge[0] + edge[1], maxCorner)
        && (edge[0] + edge[1]).z <= pivotPosition.z - 0.12 * scale
      ) {
        // draw foreground edges solid
        DrawEdge(startPos, pivotPosition, edge);
      }
    }
  }

  void DrawEdge(vec2 startPos, vec3 center, vec3[] edge) {
    nvg::StrokeWidth(1);
    nvg::BeginPath();
    vec2 curPos = startPos + vecRemoveLastD(center) + vecRemoveLastD(edge[0]);
    nvg::MoveTo(curPos);
    curPos += vecRemoveLastD(edge[1]);
    nvg::LineTo(curPos);
    nvg::ClosePath();
    nvg::Stroke();
  }

  void DrawPivot(vec2 startPos) {
    nvg::FillColor(vec4(1, 0, 0, 1));
    nvg::BeginPath();
    nvg::Circle(startPos, 5);
    nvg::ClosePath();
    nvg::Fill();
  }

  bool addUniqueSize(nat3[] arr, nat3 size) {
    for (uint i = 0; i < arr.Length; i++) {
      auto item = arr[i];
      if (item.x == size.x && item.y == size.y && item.z == size.z) {
        return false;
      }
    }
    arr.InsertLast(size);
    return true;
  }
}
