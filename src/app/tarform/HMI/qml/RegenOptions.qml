/********************************************************************************
*
* Name: RegenOptions.qml
*
* Copyright (c) Claysol Media Labs.
*
* This file is part of Tarform App Cluster.
*
* Description:
*       RegenOptions Page
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
    property bool isRegenOptionsSelected: false
    property bool isRegenOptionsTextSelected: true
    property int currentRegenOption: 0

    //Object properties
    objectName: "regenOptions"
    Accessible.name: objectName

    //Child objects
    ListView
    {
        id:regenOptionsTextList
        height:parent.height
        width: parent.width
        model:[qsTr("25%"),qsTr("50%"),qsTr("75%")]
        clip: true
        currentIndex: root.currentRegenOption
        interactive:true
        keyNavigationWraps: true

        delegate:
            Column{
            id:regenOptionsTextDelegate
            height: regenOptionsTextList.height
            spacing: 0
            Column{
                id:regenOptionsTextCol
                height: parent.height
                width: regenOptionsTextList.width
                Item{
                    id:regenOptionsTextItem
                    width: regenOptionsTextCol.width
                    height: regenOptionsTextCol.height
                    Text{
                        id:regenOptionsText
                        text:modelData
                        font{
                            pixelSize: Constants.SETTINGS_FONT_SIZE
                            letterSpacing: Constants.SETTINGS_LETTER_SPACING
                            family: fontMdCn.name
                        }
                        color:(isRegenOptionsTextSelected == true) ? normalFontColor : fontColorOnClickingOptions
                        anchors.right: regenOptionsTextItem.right
                        anchors.verticalCenter: regenOptionsTextItem.verticalCenter
                    }
                    Image {
                        id: regenOptionsHighlight
                        source: settingsHighlight
                        anchors{
                            rightMargin: 15
                            right: regenOptionsText.left
                            top: parent.top
                            topMargin: 8
                        }
                        visible:isRegenOptionsSelected
                    }
                }
            }
        }
    }

    Keys.onLeftPressed: {
        regenOptionsTextList.decrementCurrentIndex()
        root.currentRegenOption = regenOptionsTextList.currentIndex
        // console.log("left pressed",currentRegenOption)
    }

    Keys.onRightPressed: {
        regenOptionsTextList.incrementCurrentIndex()
        root.currentRegenOption = regenOptionsTextList.currentIndex
        // console.log("right pressed",currentRegenOption)
    }

    Keys.onEnterPressed:  {
        //console.log("enter key pressed");
    }

    Keys.onReturnPressed:  {
        regenOptionsRect .isRegenOptionsSelected = false
        regenOptionsRect.focus = false
        regenRect.focus = true
        regenHighlight.visible = true
        isUnitsTextSelected = true
        isSoundTextSelected = true
        isRideTextSelected = true
        isBluetoothTextSelected = true
        isDisplayTextSelected = true
        unitsOptionsRect.isUnitsOptionsTextSelected = true
        soundOptionsRect.isSoundOptionsTextSelected = true
        rideOptionsRect.isRideOptionsTextSelected = true
        displayOptionsRect.isDisplayOptionsTextSelected = true
        btOptionsRect.isBTOptionsTextSelected = true
        //console.log("return key pressed");
    }
}
