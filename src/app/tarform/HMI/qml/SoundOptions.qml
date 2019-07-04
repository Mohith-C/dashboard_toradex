/********************************************************************************
*
* Name: SoundOptions.qml
*
* Copyright (c) Claysol Media Labs.
*
* This file is part of Tarform App Cluster.
*
* Description:
*       SoundOptions Page
*
*
* Author	Lavanya-CP
* Date      11 Mar 2019
********************************************************************************/

import QtQuick 2.9
import "Constants.js" as Constants

Item {
    id:root

    //Property declarations
    property bool isSoundOptionsSelected: false
    property bool isSoundOptionsTextSelected: true
    property int currentSoundOption: 0

    //Object properties
    objectName: "soundOptions"
    Accessible.name: objectName

    //Child objects
    ListView{
        id:soundOptionsTextList
        height:parent.height
        width: parent.width
        model:[qsTr("AMBIENT"),qsTr("AGGRESSIVE"),qsTr("RUMBLE")]
        clip: true
        interactive:true
        keyNavigationWraps: true
        currentIndex: root.currentSoundOption

        delegate:
            Column{
            id:soundOptionsTextDelegate
            height: soundOptionsTextList.height
            spacing: 0
            Column{
                id:soundOptionsTextCol
                height: parent.height
                width: soundOptionsTextList.width
                Item{
                    id:soundOptionsTextItem
                    width: soundOptionsTextCol.width
                    height: soundOptionsTextCol.height
                    Text{
                        id:soundOptionsText
                        text:modelData
                        font{
                            pixelSize: Constants.SETTINGS_FONT_SIZE
                            letterSpacing: Constants.SETTINGS_LETTER_SPACING
                            family: fontMdCn.name
                        }
                        color: (isSoundOptionsTextSelected == true) ? normalFontColor : fontColorOnClickingOptions
                        anchors.right: soundOptionsTextItem.right
                        anchors.verticalCenter: soundOptionsTextItem.verticalCenter
                    }
                    Image {
                        id: soundOptionsHighlight
                        source: settingsHighlight
                        anchors{
                            rightMargin: 15
                            right: soundOptionsText.left
                            top: parent.top
                            topMargin: 8
                        }
                        visible:isSoundOptionsSelected
                    }
                }
            }
        }
    }

    Keys.onLeftPressed: {
        soundOptionsTextList.decrementCurrentIndex()
        root.currentSoundOption = soundOptionsTextList.currentIndex
        //console.log("left pressed",currentSoundOption)
    }

    Keys.onRightPressed: {
        soundOptionsTextList.incrementCurrentIndex()
        root.currentSoundOption = soundOptionsTextList.currentIndex
        // console.log("right pressed",currentSoundOption)
    }

    Keys.onEnterPressed:  {
        // console.log("enter key pressed");
    }

    Keys.onReturnPressed:  {
        soundOptionsRect.isSoundOptionsSelected = false
        soundOptionsRect.focus = false
        soundRect.focus = true
        soundHighlight.visible = true
        isRideTextSelected = true
        isUnitsTextSelected = true
        isRegenTextSelected = true
        isBluetoothTextSelected = true
        isDisplayTextSelected = true
        rideOptionsRect.isRideOptionsTextSelected = true
        unitsOptionsRect.isUnitsOptionsTextSelected = true
        regenOptionsRect.isRegenOptionsTextSelected = true
        displayOptionsRect.isDisplayOptionsTextSelected = true
        btOptionsRect.isBTOptionsTextSelected = true
        //console.log("return key pressed");
    }
}
