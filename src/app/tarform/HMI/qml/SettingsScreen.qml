/********************************************************************************
*
* Name: Settings.qml
*
* Copyright (c) Claysol Media Labs.
*
* This file is part of Tarform App Cluster.
*
* Description:
*       Settings Page
*
*
* Author	Lavanya-CP
* Date      11 Mar 2019
********************************************************************************/

//import modules and files
import QtQuick 2.9
import QtQuick.Controls 2.1
import Tarform.Elements 1.0
import "Constants.js" as Constants

Item {
    id: root

    //Property declarations
    property int batteryValue: 85
    property bool isRideTextSelected: true
    property bool isUnitsTextSelected: true
    property bool isSoundTextSelected: true
    property bool isRegenTextSelected: true
    property bool isBluetoothTextSelected: true
    property bool isDisplayTextSelected: true

    property string normalFontColor: (0 === userpreferences.readDisplayMode())? Constants.FONT_COLOR_NORMAL_DARK : Constants.FONT_COLOR_NORMAL_LIGHT
    property string fontColorOnClickingOptions:(0 === userpreferences.readDisplayMode())?Constants.FONT_COLOR_ON_CLICKING_OPTIONS_DARK : Constants.FONT_COLOR_ON_CLICKING_OPTIONS_LIGHT
    property string settingsHighlight: (0 === userpreferences.readDisplayMode()) ? Constants.IMG_NAV_ARROW_DARK : Constants.IMG_NAV_ARROW_LIGHT

    //Object properties
    objectName: "settingsScreen"
    Accessible.name: objectName
    width: Constants.SCREEN_WIDTH
    height: Constants.SCREEN_HEIGHT
    focus: true

    //Key Navigation
    function enterKeyPressed() {
        if(rideHighlight.visible == true){
            rideHighlight.visible = false
            rideOptionsRect.isRideOptionsSelected = true
            rideOptionsRect.focus = true
            isUnitsTextSelected = false
            isSoundTextSelected = false
            isRegenTextSelected = false
            isBluetoothTextSelected = false
            isDisplayTextSelected = false
            unitsOptionsRect.isUnitsOptionsTextSelected = false
            soundOptionsRect.isSoundOptionsTextSelected = false
            regenOptionsRect.isRegenOptionsTextSelected = false
            displayOptionsRect.isDisplayOptionsTextSelected = false
            btOptionsRect.isBTOptionsTextSelected = false
        }
        else if(unitsHighlight.visible == true){
            unitsHighlight.visible = false
            unitsOptionsRect.isUnitsOptionsSelected = true
            unitsOptionsRect.focus = true
            isRideTextSelected = false
            isSoundTextSelected = false
            isRegenTextSelected = false
            isBluetoothTextSelected = false
            isDisplayTextSelected = false
            rideOptionsRect.isRideOptionsTextSelected = false
            regenOptionsRect.isRegenOptionsTextSelected = false
            soundOptionsRect.isSoundOptionsTextSelected = false
            btOptionsRect.isBTOptionsTextSelected = false
            displayOptionsRect.isDisplayOptionsTextSelected = false
        }
        else if(soundHighlight.visible == true){
            soundHighlight.visible = false
            soundOptionsRect.isSoundOptionsSelected = true
            soundOptionsRect.focus = true
            isRideTextSelected = false
            isUnitsTextSelected = false
            isRegenTextSelected = false
            isBluetoothTextSelected = false
            isDisplayTextSelected = false
            rideOptionsRect.isRideOptionsTextSelected = false
            regenOptionsRect.isRegenOptionsTextSelected = false
            displayOptionsRect.isDisplayOptionsTextSelected = false
            btOptionsRect.isBTOptionsTextSelected = false
            unitsOptionsRect.isUnitsOptionsTextSelected =false
        }
        else if(regenHighlight.visible == true){
            regenHighlight.visible = false
            regenOptionsRect.isRegenOptionsSelected = true
            regenOptionsRect.focus = true
            isRideTextSelected = false
            isUnitsTextSelected = false
            isSoundTextSelected = false
            isBluetoothTextSelected = false
            isDisplayTextSelected = false
            soundOptionsRect.isSoundOptionsTextSelected = false
            rideOptionsRect.isRideOptionsTextSelected = false
            displayOptionsRect.isDisplayOptionsTextSelected = false
            btOptionsRect.isBTOptionsTextSelected = false
            unitsOptionsRect.isUnitsOptionsTextSelected =false
        }
        else if(bluetoothHighlight.visible == true){
            bluetoothHighlight.visible = false
            btOptionsRect.isBTOptionsSelected = true
            btOptionsRect.focus = true
            isRideTextSelected = false
            isUnitsTextSelected = false
            isRegenTextSelected = false
            isSoundTextSelected = false
            isDisplayTextSelected = false
            rideOptionsRect.isRideOptionsTextSelected = false
            unitsOptionsRect.isUnitsOptionsTextSelected = false
            soundOptionsRect.isSoundOptionsTextSelected = false
            regenOptionsRect.isRegenOptionsTextSelected = false
            displayOptionsRect.isDisplayOptionsTextSelected = false
        }
        else if(displayHighlight.visible == true){
            displayHighlight.visible = false
            displayOptionsRect.isDisplayOptionsSelected = true
            displayOptionsRect . focus = true
            isRideTextSelected = false
            isUnitsTextSelected = false
            isRegenTextSelected = false
            isBluetoothTextSelected = false
            isSoundTextSelected = false
            rideOptionsRect.isRideOptionsTextSelected = false
            unitsOptionsRect.isUnitsOptionsTextSelected = false
            soundOptionsRect.isSoundOptionsTextSelected = false
            regenOptionsRect.isRegenOptionsTextSelected = false
            btOptionsRect.isBTOptionsTextSelected = false
        }
    }

    function downKeyPressed() {
        if(rideHighlight.visible == true){
            rideHighlight.visible = false
            unitsHighlight.visible = true
        }
        else if(unitsHighlight.visible == true){
            unitsHighlight.visible = false
            soundHighlight.visible = true
        }
        else if(soundHighlight.visible == true){
            soundHighlight.visible = false
            regenHighlight.visible = true
        }
        else if(regenHighlight.visible == true){
            regenHighlight.visible = false
            bluetoothHighlight.visible = true
        }
        else if(bluetoothHighlight.visible == true){
            bluetoothHighlight.visible = false
            displayHighlight.visible = true
        }

        // console.log("down key pressed");
    }

    function upKeyPressed() {
        if(displayHighlight.visible == true){
            displayHighlight.visible = false
            bluetoothHighlight.visible = true
        }
        else if(bluetoothHighlight.visible == true){
            bluetoothHighlight.visible = false
            regenHighlight.visible = true
        }
        else if(regenHighlight.visible == true){
            regenHighlight.visible = false
            soundHighlight.visible = true
        }
        else if(soundHighlight.visible == true){
            soundHighlight.visible = false
            unitsHighlight.visible = true
        }
        else if(unitsHighlight.visible == true){
            unitsHighlight.visible = false
            rideHighlight.visible = true
        }
        // console.log("up key pressed");
    }

    Keys.onPressed: {
        switch (event.key) {
        case Qt.Key_Enter:
        case Qt.Key_Return:
            enterKeyPressed();
            break;
        case Qt.Key_Up:
            upKeyPressed();
            break;
        case Qt.Key_Down :
            downKeyPressed();
            break;
        default:
            break;
        }
    }
    //!Key Navigation

    //Child objects
    SettingsUtility {
        id: userpreferences
    }

    FontLoader { id: fontMdCn; source: "qrc:/fonts/MdCn" }
    FontLoader { id: fontDemiCn; source: "qrc:/fonts/DemiCn" }
    FontLoader { id: fontXLtCn; source: "qrc:/fonts/XLtCn" }

    Image {
        id: outerRing
        anchors.fill:parent
        source: Constants.IMG_OUTER_RING
    }

    Text {
        id: settingsText
        text: qsTr("SETTINGS")
        y: 100
        font{
            pixelSize: Constants.SETTINGS_FONT_SIZE
            family: fontMdCn.name
            letterSpacing: Constants.SETTINGS_TITLE_LETTER_SPACING
        }
        color: normalFontColor
        anchors.horizontalCenter: parent.horizontalCenter
    }


    Item{
        id:settingMenu
        y: 150
        height: 450
        width: 650
        anchors {
            top: settingsText.bottom
            topMargin: 50
            horizontalCenter: parent.horizontalCenter
        }
        Column{
            Row{
                id:rideRow

                Item{
                    id:rideRect
                    width: settingMenu.width/3 - 35
                    height: settingMenu.height/6
                    Text {
                        id: rideText
                        text: qsTr("RIDE")
                        font{
                            pixelSize: Constants.SETTINGS_FONT_SIZE
                            letterSpacing: Constants.SETTINGS_LETTER_SPACING
                            family: fontMdCn.name
                        }
                        color: (isRideTextSelected == true) ? normalFontColor : fontColorOnClickingOptions
                        anchors.verticalCenter: rideRect.verticalCenter
                    }
                    Image {
                        id: rideHighlight
                        source: settingsHighlight

                        anchors{
                            leftMargin: 15
                            left: rideText.right
                            top: parent.top
                            topMargin: 8
                        }
                        visible:true
                    }
                }
                RideOptions{
                    id:rideOptionsRect
                    currentRideOption: userpreferences.readRideMode()
                    width: settingMenu.width - rideRect.width
                    height: settingMenu.height/6

                    onCurrentRideOptionChanged: {
                        userpreferences.saveRideMode(currentRideOption)
                        userpreferences.setRideMode(currentRideOption)
                    }
                }
            }

            Row{
                id:unitsRow

                Item{
                    id:unitsRect
                    width: settingMenu.width/2
                    height:settingMenu.height/6
                    Text {
                        id: unitsText
                        text: qsTr("UNITS")
                        font{
                            pixelSize: Constants.SETTINGS_FONT_SIZE
                            letterSpacing: Constants.SETTINGS_LETTER_SPACING
                            family: fontMdCn.name
                        }
                        color: (isUnitsTextSelected == true) ? normalFontColor : fontColorOnClickingOptions
                        anchors.verticalCenter: unitsRect.verticalCenter

                    }
                    Image {
                        id: unitsHighlight
                        source: settingsHighlight
                        anchors{
                            leftMargin: 15
                            left: unitsText.right
                            top: parent.top
                            topMargin: 8
                        }
                        visible:false
                    }
                }
                UnitsOptions{
                    id:unitsOptionsRect
                    currentUnitsOption: userpreferences.readUnits()
                    width: settingMenu.width/2
                    height:settingMenu.height/6
                    onCurrentUnitsOptionChanged: {
                        userpreferences.saveUnits(currentUnitsOption)
                    }
                }
            }

            Row{
                id:soundRow

                Item{
                    id:soundRect
                    width: settingMenu.width/3
                    height:settingMenu.height/6
                    Text {
                        id: soundText
                        text: qsTr("SOUND")
                        font{
                            pixelSize: Constants.SETTINGS_FONT_SIZE
                            letterSpacing: Constants.SETTINGS_LETTER_SPACING
                            family: fontMdCn.name
                        }
                        color: (isSoundTextSelected == true) ? normalFontColor : fontColorOnClickingOptions
                        anchors.verticalCenter: soundRect.verticalCenter
                    }

                    Image {
                        id: soundHighlight
                        source: settingsHighlight
                        anchors{
                            leftMargin: 15
                            left: soundText.right
                            top: parent.top
                            topMargin: 8
                        }
                        visible:false
                    }
                }

                SoundOptions{
                    id:soundOptionsRect
                    currentSoundOption: userpreferences.readSoundMode()
                    width: settingMenu.width - soundRect.width
                    height: settingMenu.height/6
                    onCurrentSoundOptionChanged:{
                        userpreferences.saveSoundMode(currentSoundOption)
                        m_audioHandler.updateSoundProfile();
                    }
                }
            }

            Row{
                id:regenRow

                Item{
                    id:regenRect
                    width: settingMenu.width/2
                    height:settingMenu.height/6
                    Text {
                        id: regenText
                        text: qsTr("REGEN")
                        font{
                            pixelSize: Constants.SETTINGS_FONT_SIZE
                            letterSpacing: Constants.SETTINGS_LETTER_SPACING
                            family: fontMdCn.name
                        }
                        color: (isRegenTextSelected == true) ? normalFontColor : fontColorOnClickingOptions
                        anchors.verticalCenter: regenRect.verticalCenter
                    }
                    Image {
                        id: regenHighlight
                        source: settingsHighlight
                        anchors{
                            leftMargin: 15
                            left: regenText.right
                            top: parent.top
                            topMargin: 8
                        }
                        visible:false
                    }
                }
                RegenOptions{
                    id:regenOptionsRect
                    currentRegenOption: userpreferences.readRegenMode()
                    width: settingMenu.width/2
                    height: settingMenu.height/6
                    onCurrentRegenOptionChanged:{
                        userpreferences.saveRegenMode(currentRegenOption)
                        userpreferences.setRegenMode(currentRegenOption)
                    }
                }
            }

            Row{
                id:bluetoothRow

                Item{
                    id:bluetoothRect
                    width: settingMenu.width/2
                    height:settingMenu.height/6
                    Text {
                        id: bluetoothText
                        text: qsTr("BLUETOOTH")
                        font{
                            pixelSize: Constants.SETTINGS_FONT_SIZE
                            letterSpacing: Constants.SETTINGS_LETTER_SPACING
                            family: fontMdCn.name
                        }
                        color: (isBluetoothTextSelected == true) ? normalFontColor : fontColorOnClickingOptions
                        anchors.verticalCenter: bluetoothRect.verticalCenter
                    }
                    Image {
                        id: bluetoothHighlight
                        source: settingsHighlight
                        anchors{
                            leftMargin: 15
                            left: bluetoothText.right
                            top: parent.top
                            topMargin: 8
                        }
                        visible:false
                    }
                }
                BluetoothOptions{
                    id:btOptionsRect
                    width: settingMenu.width/2
                    height: settingMenu.height/6

                }
            }

            Row{
                id:displayRow

                Item{
                    id:displayRect
                    width: settingMenu.width/2
                    height:settingMenu.height/6
                    Text {
                        id: displayText
                        text: qsTr("DISPLAY")
                        font{
                            pixelSize: Constants.SETTINGS_FONT_SIZE
                            letterSpacing: Constants.SETTINGS_LETTER_SPACING
                            family: fontMdCn.name
                        }
                        color: (isDisplayTextSelected == true)? normalFontColor : fontColorOnClickingOptions
                        anchors.verticalCenter: displayRect.verticalCenter
                    }
                    Image {
                        id: displayHighlight
                        source:settingsHighlight
                        anchors{
                            leftMargin: 15
                            left: displayText.right
                            top: parent.top
                            topMargin: 8
                        }
                        visible: false
                    }
                }
                DisplayOptions{
                    id:displayOptionsRect
                    currentDisplayOption: userpreferences.readDisplayMode()
                    width: settingMenu.width/2
                    height: settingMenu.height/6
                    onCurrentDisplayOptionChanged:{
                        userpreferences.saveDisplayMode(currentDisplayOption)
                    }
                }
            }
        }
    }
}








