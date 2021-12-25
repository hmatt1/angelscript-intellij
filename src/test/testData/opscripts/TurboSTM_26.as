/*
 Adapted from the Plugin_TurboSTM.as script shipped
 with Openplanet Turbo version 1.19.0 (2021-08-01)
*/

namespace TurboSTM
{
  class SuperTime
  {
    int m_number;
    uint m_time;
    string m_player;
  }
  
#if TURBO
  array<SuperTime@> g_superTimes;
  
  SuperTime@ GetSuperTime(int number)
  {
    for (uint i = 0; i < g_superTimes.Length; i++) {
      if (g_superTimes[i].m_number == number) {
        return g_superTimes[i];
      }
    }
    return null;
  }
  
  CSystemFidFile@ GetFile(const string &in path, const string &in match = "")
  {
    for (uint i = 0; i < Fids::AllPacks.Length; i++) {
      auto pack = Fids::AllPacks[i];
      if(match.Length > 0 && !pack.CreationBuildInfo.Contains(match)) {
        continue;
      }
      auto file = pack.Location.GetFile(path);
      if (file !is null) {
        print("match");
        return file;
      }
    }
    if(match.Length > 0) {
      print("fallback");
      return GetFile(path);
    }
    return null;
  }
  
  void Initialize()
  {
    /*
    while (Fids::AllPacks.Length != 2) {
      yield();
    }
  
    // Filter for the Update file... very few differences are to be found,
    // but we do have access to the CreationBuildInfo
    auto superSoloFile = GetFile("Media/Config/TMConsole/Campaign/SuperSoloCampaign.xml", "2016-09-29_18_08"); // TMTurbo_Update
    //auto superSoloFile = GetFile("Media/Config/TMConsole/Campaign/SuperSoloCampaign.xml", "2016-03-21_17_07"); // TMTurbo
    if (superSoloFile is null || !superSoloFile.Preload()) {
      print("Unable to preload SuperSoloCampaign file!");
      return;
    }
  
    auto superSoloText = cast<CPlugFileText>(superSoloFile.Nod);
    if (superSoloText is null) {
      print("SuperSoloCampaign file is not a CPlugFileText file!");
      return;
    }
    */
    
    // Use a pre-extracted version of the SuperSoloCampaign.xml, because the
    // game seems overly reluctant to load the right one. (This may be a bug
    // within the game, but I'm unsure so far.)
    IO::FileSource superSoloFile("lib/SuperSoloCampaign.xml");
    if (superSoloFile.Size() <= 0) {
      print("Unable to access SuperSoloCampaign file!");
      return;
    }
  
    auto superSoloDoc = XML::Document(superSoloFile.ReadToEnd());
    auto nodeRoot = superSoloDoc.Root();
  
    auto nodeTrackList = nodeRoot.Child("supersolocampaign");
    auto nodeTrack = nodeTrackList.FirstChild();
    while (nodeTrack) {
      auto newSuperTime = SuperTime();
      newSuperTime.m_number = Text::ParseInt(nodeTrack.Attribute("id")) + 1;
      newSuperTime.m_time = Text::ParseUInt(nodeTrack.Attribute("superauthortime"));
      newSuperTime.m_player = nodeTrack.Attribute("superplayer");
      g_superTimes.InsertLast(newSuperTime);
  
      nodeTrack = nodeTrack.NextSibling();
    }
  }
#else
  SuperTime@ GetSuperTime(int number) { return null; }
  CSystemFidFile@ GetFile(const string &in path) { return null; }
  void Initialize() {}
#endif
}