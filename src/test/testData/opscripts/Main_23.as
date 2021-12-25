#name "Chat-Button-Bar"
#author "RoboTec13"
#category "Race"

int[] buttonCanNotBePressed;
bool permission;

void Main() {
    permission = Permissions::InGameChat();
    while(true) {
        checkIfButtonsCanNotBeClicked();
        yield();
    }
}

void checkIfButtonsCanNotBeClicked() {
    for (uint i = 0; i < buttonCanNotBePressed.Length; i++) {
        resetButtonCanBeClicked(i);
    }
}

void resetButtonCanBeClicked(int buttonIndex) {
  sleep(1000);
  buttonCanNotBePressed.RemoveAt(buttonIndex);
}
