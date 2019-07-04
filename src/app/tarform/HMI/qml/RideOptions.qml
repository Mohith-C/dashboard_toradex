/********************************************************************************
*
* Name: RideOptions.qml
*
* Copyright (c) Claysol Media Labs.
*
* This file is part of Tarform App Cluster.
*
* Description:
*       RideOptions Page
*
*
* Author	Lavanya-CP
* Date      11 Mar 2019
********************************************************************************/

import QtQuick 2.9
import "Constants.js" as Constants

Item{
    id:root

    //Property declarations
    property bool isRideOptionsSelected:false
    property bool isRideOptionsTextSelected: true
    property int currentRideOption: 0


    //Object properties
    objectName: "rideOptions"
    Accessible.name: objectName


    //Child objects
    ListView
    {
        id:rideOptionsTextList
        height:parent.height
        width: parent.width
        model:[qsTr("ECO"),qsTr("STANDARD"),qsTr("SPORT")]
        clip: true
        interactive:true
        currentIndex: root.currentRideOption
        keyNavigationWraps: true

        delegate:
            Column{
            id:rideOptionsTextDelegate
            height: rideOptionsTextList.height
            spacing: 0
            Column{
                id:rideOptionsTextCol
                height: parent.height
                width: rideOptionsTextList.width
                Item{
                    id:rideOptionsTextItem
                    width: rideOptionsTextCol.width
                    height: rideOptionsTextCol.height
                    Text{
                        id:rideOptionsText
                        text:modelData + " MODE"
                        font{
                            pixelSize: Constants.SETTINGS_FONT_SIZE
                            letterSpacing: Constants.SETTINGS_LETTER_SPACING
                            family: fontMdCn.name
                        }
                        color: (isRideOptionsTextSelected == true) ? normalFontColor :fontColorOnClickingOptions
                        anchors.right: rideOptionsTextItem.right
                        anchors.verticalCenter: rideOptionsTextItem.verticalCenter
                    }
                    Image {
                        id: rideOptionsHighlight
                        source: settingsHighlight
                        anchors{
                            right: rideOptionsText.left
                            rightMargin: 15
                            top: parent.top
                            topMargin: 8
                        }
                        visible:isRideOptionsSelected
                    }
                }
            }
        }
    }

    Keys.onLeftPressed: {
        rideOptionsTextList.decrementCurrentIndex()
        root.currentRideOption = rideOptionsTextList.currentIndex
        // console.log("left pressed",currentRideOption)
    }

    Keys.onRightPressed: {
        rideOptionsTextList.incrementCurrentIndex()
        root.currentRideOption = rideOptionsTextList.currentIndex
        // console.log("right pressed",currentRideOption)
    }

    Keys.onEnterPressed:  {
        //console.log("enter key pressed");
    }

    Keys.onReturnPressed:  {
        rideOptionsRect.isRideOptionsSelected = false
        rideOptionsRect.focus = false
        rideRect.focus = true
        rideHighlight.visible = true
        isUnitsTextSelected= true
        isSoundTextSelected = true
        isRegenTextSelected = true
        isBluetoothTextSelected = true
        isDisplayTextSelected = true
        unitsOptionsRect.isUnitsOptionsTextSelected = true
        soundOptionsRect.isSoundOptionsTextSelected = true
        regenOptionsRect.isRegenOptionsTextSelected = true
        displayOptionsRect.isDisplayOptionsTextSelected = true
        btOptionsRect.isBTOptionsTextSelected = true
        //console.log("return key pressed");
    }
}



