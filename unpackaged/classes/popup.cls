public with sharing class popup {

    public boolean displayPopUp { get; set; }

    public void closePopup() {
        displayPopup = false;
    }

    public void showPopup() {
        displayPopup = true;
    }

}