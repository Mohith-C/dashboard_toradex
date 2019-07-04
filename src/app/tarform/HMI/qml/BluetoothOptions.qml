/********************************************************************************
*
* Name: BluetoothOptions.qml
*
* Copyright (c) Claysol Media Labs.
*
* This file is part of Tarform App Cluster.
*
* Description:
*       BluetoothOptions Page
*
*
* Author	Lavanya-CP
* Date      11 Mar 2019
********************************************************************************/
//Import modules and files
import QtQuick 2.9
import "Constants.js" as Constants

Item {
    id:root

    //Property declarations
    property bool isBTOptionsSelected : false
    property bool isBTpaired : false
    property bool isBTOptionsTextSelected: true
    property int currentBTOption: 0

    //Object properties
    objectName: "bluetoothOptions"
    Accessible.name: objectName

    //Child objects
    ListView {
        id:btOptionsTextList
        height:parent.height
        width: parent.width
        model:[qsTr("DISABLED"),qsTr("ENABLED")]
        clip: true
        interactive:true
        currentIndex: 0
        delegate: Column{
            id:btOptionsTextDelegate
            height: btOptionsTextList.height
            spacing: 0
            Column{
                id:btOptionsTextCol
                height: parent.height
                width: btOptionsTextList.width
                Item{
                    id:btOptionsTextItem
                    width: btOptionsTextCol.width
                    height: btOptionsTextCol.height
                    Text{
                        id:btOptionsText
                        text:modelData
                        font{
                            pixelSize: Constants.SETTINGS_FONT_SIZE
                            family: fontMdCn.name
                            letterSpacing: Constants.SETTINGS_LETTER_SPACING
                        }
                        color:(isBTOptionsTextSelected == true) ? normalFontColor : fontColorOnClickingOptions
                        anchors.right: btOptionsTextItem.right
                        anchors.verticalCenter: btOptionsTextItem.verticalCenter
                    }
                    Image {
                        id: btOptionsHighlight
                        source: settingsHighlight
                        anchors{
                            rightMargin: 15
                            right: btOptionsText.left
                            top: parent.top
                            topMargin: 8
                        }
                        visible:isBTOptionsSelected
                    }
                }
            }
        }
    }

    Keys.onLeftPressed: {
        btOptionsTextList.decrementCurrentIndex()
        root.currentBTOption = btOptionsTextList.currentIndex
        //console.log("left pressed",currentBTOption)
    }

    Keys.onRightPressed: {
        btOptionsTextList.incrementCurrentIndex()
        root.currentBTOption = btOptionsTextList.currentIndex
        //console.log("right pressed",currentBTOption)
    }

    Keys.onEnterPressed:  {
        // console.log("enter key pressed");
    }

    Keys.onReturnPressed:  {
        btOptionsRect.isBTOptionsSelected = false
        btOptionsRect.focus = false
        bluetoothRect.focus = true
        bluetoothHighlight.visible = true
        isUnitsTextSelected = true
        isSoundTextSelected = true
        isRegenTextSelected = true
        isRideTextSelected = true
        isDisplayTextSelected = true
        unitsOptionsRect.isUnitsOptionsTextSelected = true
        soundOptionsRect.isSoundOptionsTextSelected = true
        regenOptionsRect.isRegenOptionsTextSelected = true
        displayOptionsRect.isDisplayOptionsTextSelected = true
        rideOptionsRect.isRideOptionsTextSelected = true
        //console.log("return key pressed");
    }
}
