namespace Keybindings {
  VirtualKey[] keys = {
    VirtualKey::Up,
    VirtualKey::Down,
    VirtualKey::Left,
    VirtualKey::Right,
    VirtualKey::Prior,
    VirtualKey::Next,
    VirtualKey::N,
    VirtualKey::L,
    VirtualKey::J,
    VirtualKey::T,
    VirtualKey::B
  };
  VirtualKey[] defaultKeys = {
    VirtualKey::Up,
    VirtualKey::Down,
    VirtualKey::Left,
    VirtualKey::Right,
    VirtualKey::Prior,
    VirtualKey::Next,
    VirtualKey::N,
    VirtualKey::L,
    VirtualKey::J,
    VirtualKey::T,
    VirtualKey::B
  };
  string[] names = {
    "Forward",
    "Backward",
    "Left",
    "Right",
    "Up",
    "Down",
    "ToggleFixedCursor",
    "ToggleNudgeMode",
    "ToggleRelativeNudging",
    "ToggleVariableUpdate",
    "CycleAxis"
  };
  string[] description = {
    "Moves the block in the horizontal plane",
    "Moves the block in the horizontal plane",
    "Moves the block in the horizontal plane",
    "Moves the block in the horizontal plane",
    "Moves the block on the vertical axis",
    "Moves the block on the vertical axis",
    "",
    "",
    "",
    "",
    "Only used in Nudge Mode 'SelectedAxis'"
  };

  void SetKey(string name, VirtualKey key) {
    uint i = names.Find(name);
    if (i >= 0 && i < names.Length) {
      keys[i] = key;
    }
  }

  VirtualKey GetKey(string name) {
    uint i = names.Find(name);
    if (i >= 0 && i < names.Length) {
      return keys[i];
    }
    return VirtualKey(0);
  }
  string GetKeyString(string name) {
    uint i = names.Find(name);
    if (i >= 0 && i < names.Length) {
      return virtualKeyToString(keys[i]);
    }
    return "";
  }
  string GetKeyDescription(string name) {
    uint i = names.Find(name);
    if (i >= 0 && i < names.Length) {
      return description[i];
    }
    return "";
  }

  VirtualKey GetDefaultKey(string name) {
    uint i = names.Find(name);
    if (i >= 0 && i < names.Length) {
      return defaultKeys[i];
    }
    return VirtualKey(0);
  }

  void ResetKey(string name) {
    uint i = names.Find(name);
    if (i >= 0 && i < names.Length) {
      keys[i] = defaultKeys[i];
    }
  }

  void ResetAllKeys() {
    for (uint i = 0; i < keys.Length; i++) {
      keys[i] = defaultKeys[i];
    }
  }

  void SetKeysToOldMapping() {
    keys = {
      VirtualKey::I,
      VirtualKey::K,
      VirtualKey::J,
      VirtualKey::L,
      VirtualKey::N,
      VirtualKey::B,
      VirtualKey(0),
      VirtualKey::G,
      VirtualKey::O,
      VirtualKey::T,
      VirtualKey(0)
    };
  }

  string Serialize() {
    Json::Value json = Json::Object();

    for (uint i = 0; i < keys.Length; i++) {
      json[names[i]] = Json::Value(int(keys[i]));
    }

    return Json::Write(json);
  }

  void Deserialize(string text) {
    Json::Value json = Json::Parse(text);
    if (json.GetType() != Json::Type::Object) return;
    string[]@ names = json.GetKeys();
    for (uint i = 0; i < names.Length; i++) {
      int key = json[names[i]];
      SetKey(names[i], VirtualKey(key));
    }
  }
}
