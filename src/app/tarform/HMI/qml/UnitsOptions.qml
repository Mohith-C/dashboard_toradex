/********************************************************************************
*
* Name: UnitsOptions.qml
*
* Copyright (c) Claysol Media Labs.
*
* This file is part of Tarform App Cluster.
*
* Description:
*       UnitsOptions Page
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
    property bool isUnitsOptionsSelected:false
    property bool isUnitsOptionsTextSelected: true
    property int currentUnitsOption: 0

    //Object properties
    objectName: "unitsOptions"
    Accessible.name: objectName

    //Child objects
    ListView
    {
        id:unitsOptionsTextList
        height:parent.height
        width: parent.width
        model:[qsTr("MILES"),qsTr("KILOMETERS")]
        clip: true
        interactive:true
        currentIndex: root.currentUnitsOption
        keyNavigationWraps: true

        delegate:
            Column{
            id:unitsOptionsTextDelegate
            height: unitsOptionsTextList.height
            spacing: 0
            Column{
                id:unitsOptionsTextCol
                height: parent.height
                width: unitsOptionsTextList.width
                Item{
                    id:unitsOptionsTextItem
                    width: unitsOptionsTextCol.width
                    height: unitsOptionsTextCol.height
                    Text{
                        id:unitsOptionsText
                        text:modelData
                        font{
                            pixelSize: Constants.SETTINGS_FONT_SIZE
                            letterSpacing: Constants.SETTINGS_LETTER_SPACING
                            family: fontMdCn.name
                        }
                        color: (isUnitsOptionsTextSelected == true) ? normalFontColor : fontColorOnClickingOptions
                        anchors.right: unitsOptionsTextItem.right
                        anchors.verticalCenter: unitsOptionsTextItem.verticalCenter
                    }
                    Image {
                        id: unitsOptionsHighlight
                        source: settingsHighlight
                        anchors{
                            right: unitsOptionsText.left
                            rightMargin: 15
                            top: parent.top
                            topMargin: 8
                        }
                        visible:isUnitsOptionsSelected
                    }
                }
            }
        }
    }

    Keys.onLeftPressed: {
        unitsOptionsTextList.decrementCurrentIndex()
        root.currentUnitsOption = unitsOptionsTextList.currentIndex
        // console.log("left pressed",currentRideOption)
    }

    Keys.onRightPressed: {
        unitsOptionsTextList.incrementCurrentIndex()
        root.currentUnitsOption = unitsOptionsTextList.currentIndex
        // console.log("right pressed",currentRideOption)
    }

    Keys.onEnterPressed:  {
        //console.log("enter key pressed");
    }

    Keys.onReturnPressed:  {
        unitsOptionsRect.isUnitsOptionsSelected = false
        unitsOptionsRect.focus = false
        unitsRect.focus = true
        unitsHighlight.visible = true
        isRideTextSelected= true
        isSoundTextSelected = true
        isRegenTextSelected = true
        isBluetoothTextSelected = true
        isDisplayTextSelected = true
        rideOptionsRect.isRideOptionsTextSelected = true
        soundOptionsRect.isSoundOptionsTextSelected = true
        regenOptionsRect.isRegenOptionsTextSelected = true
        displayOptionsRect.isDisplayOptionsTextSelected = true
        btOptionsRect.isBTOptionsTextSelected = true
        //console.log("return key pressed");
    }
}



