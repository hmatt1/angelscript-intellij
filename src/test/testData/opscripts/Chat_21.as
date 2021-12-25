#name "Chat-Button-Bar"
#author "RoboTec13"
#category "Race"

void RenderInterface() {
  if (permission) {
    // hide if unwanted
    if (Show_Chat_Button_Bar && getTmApp().RootMap !is null && isServer()) {
      if (Setting_View_Chat_Pos.y <= 0) {
        Setting_View_Height = Draw::GetHeight();
        Setting_View_Chat_Pos = vec2(Setting_View_Chat_Pos.x, Setting_View_Height + Setting_View_Chat_Pos.y);
      }
      UI::PushStyleColor(UI::Col::WindowBg, vec4(0,0,0,0));
      UI::PushStyleColor(UI::Col::Button, Setting_View_Chat_Button_Color);
      UI::PushStyleColor(UI::Col::ButtonHovered, Setting_View_Chat_Button_Hover_Color);
      UI::Begin("Chat", UI::WindowFlags::NoCollapse | UI::WindowFlags::AlwaysAutoResize | UI::WindowFlags::NoTitleBar);
      UI::SetWindowPos(Setting_View_Chat_Pos);
      createButton(Setting_Config_Chat_Button_1, 1);
      createButton(Setting_Config_Chat_Button_2, 2);
      createButton(Setting_Config_Chat_Button_3, 3);
      createButton(Setting_Config_Chat_Button_4, 4);
      createButton(Setting_Config_Chat_Button_5, 5);
      createButton(Setting_Config_Chat_Button_6, 6);
      createButton(Setting_Config_Chat_Button_7, 7);
      createButton(Setting_Config_Chat_Button_8, 8);
      createButton(Setting_Config_Chat_Button_9, 9);
      createButton(Setting_Config_Chat_Button_10, 10);
      createButton(Setting_Config_Chat_Button_11, 11);
      createButton(Setting_Config_Chat_Button_12, 12);
      createButton(Setting_Config_Chat_Button_13, 13);
      createButton(Setting_Config_Chat_Button_14, 14);
      createButton(Setting_Config_Chat_Button_15, 15);
      createButton(Setting_Config_Chat_Button_16, 16);
      createButton(Setting_Config_Chat_Button_17, 17);
      createButton(Setting_Config_Chat_Button_18, 18);
      createButton(Setting_Config_Chat_Button_19, 19);
      createButton(Setting_Config_Chat_Button_20, 20);
      UI::End();
      UI::PopStyleColor();
      UI::PopStyleColor();
      UI::PopStyleColor();
    }
  }
}

void createButton(string buttonName, int buttonNumber) {
      if (buttonName != "") {
        if (UI::Button(buttonName) && checkIfButtonCanPressed(buttonNumber)) {
          sendMessage(buttonNumber);
        }
        UI::SameLine();
      }
}

void sendMessage(int buttonNumber) {
  CSmArenaClient@ playground = cast<CSmArenaClient>(cast<CTrackMania>(GetApp()).CurrentPlayground);
  CGamePlaygroundInterface@ playgroundInterface = cast<CGamePlaygroundInterface>(playground.Interface);
  switch(buttonNumber) {
    case 1: playgroundInterface.ChatEntry = Setting_Config_Chat_Text_1; return;
    case 2: playgroundInterface.ChatEntry = Setting_Config_Chat_Text_2; return;
    case 3: playgroundInterface.ChatEntry = Setting_Config_Chat_Text_3; return;
    case 4: playgroundInterface.ChatEntry = Setting_Config_Chat_Text_4; return;
    case 5: playgroundInterface.ChatEntry = Setting_Config_Chat_Text_5; return;
    case 6: playgroundInterface.ChatEntry = Setting_Config_Chat_Text_6; return;
    case 7: playgroundInterface.ChatEntry = Setting_Config_Chat_Text_7; return;
    case 8: playgroundInterface.ChatEntry = Setting_Config_Chat_Text_8; return;
    case 9: playgroundInterface.ChatEntry = Setting_Config_Chat_Text_9; return;
    case 10: playgroundInterface.ChatEntry = Setting_Config_Chat_Text_10; return;
    case 11: playgroundInterface.ChatEntry = Setting_Config_Chat_Text_11; return;
    case 12: playgroundInterface.ChatEntry = Setting_Config_Chat_Text_12; return;
    case 13: playgroundInterface.ChatEntry = Setting_Config_Chat_Text_13; return;
    case 14: playgroundInterface.ChatEntry = Setting_Config_Chat_Text_14; return;
    case 15: playgroundInterface.ChatEntry = Setting_Config_Chat_Text_15; return;
    case 16: playgroundInterface.ChatEntry = Setting_Config_Chat_Text_16; return;
    case 17: playgroundInterface.ChatEntry = Setting_Config_Chat_Text_17; return;
    case 18: playgroundInterface.ChatEntry = Setting_Config_Chat_Text_18; return;
    case 19: playgroundInterface.ChatEntry = Setting_Config_Chat_Text_19; return;
    case 20: playgroundInterface.ChatEntry = Setting_Config_Chat_Text_20; return;
  }
}

bool checkIfButtonCanPressed(int buttonNumber) {
  for (uint i = 0; i < buttonCanNotBePressed.Length; i++) {
    if (buttonCanNotBePressed[i] == buttonNumber) {
      return false;
    }
  }
  buttonCanNotBePressed.InsertLast(buttonNumber);
  return true;
}
