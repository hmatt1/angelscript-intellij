interface ScriptLogic {}
class PlayerLogic : ScriptLogic {}
ScriptLogic @getScriptObject() { return PlayerLogic(); }
