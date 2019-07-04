/********************************************************************************
*
* Name: DisplayOptions.qml
*
* Copyright (c) Claysol Media Labs.
*
* This file is part of Tarform App Cluster.
*
* Description:
*       DisplayOptions Page
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
    property bool isDisplayOptionsSelected: false
    property bool isDisplayOptionsTextSelected: true
    property int currentDisplayOption: 0

    //Object properties
    objectName: "displayOptions"
    Accessible.name: objectName

    //Child objects
    ListView
    {
        id:displayOptionsTextList
        height:parent.height
        width: parent.width
        model:[qsTr("DARK"),qsTr("LIGHT")]
        clip: true
        interactive:true
        keyNavigationWraps: true
        currentIndex: root.currentDisplayOption

        delegate:
            Column{
            id:displayOptionsTextDelegate
            height: displayOptionsTextList.height
            spacing: 0
            Column{
                id:displayOptionsTextCol
                height: parent.height
                width: displayOptionsTextList.width
                Item{
                    id:displayOptionsTextItem
                    width: displayOptionsTextCol.width
                    height: displayOptionsTextCol.height

                    Text{
                        id:displayOptionsText
                        text:modelData
                        font{
                            pixelSize: Constants.SETTINGS_FONT_SIZE
                            letterSpacing: Constants.SETTINGS_LETTER_SPACING
                            family: fontMdCn.name
                        }
                        color:(isDisplayOptionsTextSelected == true) ? normalFontColor : fontColorOnClickingOptions
                        anchors.right: displayOptionsTextItem.right
                        anchors.verticalCenter: displayOptionsTextItem.verticalCenter
                    }
                    Image {
                        id: displayOptionsHighlight
                        source: settingsHighlight
                        anchors{
                            rightMargin: 15
                            right: displayOptionsText.left
                            top: parent.top
                            topMargin: 8
                        }
                        visible: isDisplayOptionsSelected
                    }
                }
            }
        }
    }

    Keys.onLeftPressed: {
        displayOptionsTextList.decrementCurrentIndex()
        root.currentDisplayOption = displayOptionsTextList.currentIndex
        //console.log("left pressed",currentDisplayOption)
    }

    Keys.onRightPressed: {
        displayOptionsTextList.incrementCurrentIndex()
        root.currentDisplayOption = displayOptionsTextList.currentIndex
        //console.log("right pressed",currentDisplayOption)
    }

    Keys.onEnterPressed:  {
        //console.log("enter key pressed");
    }

    Keys.onReturnPressed:  {
        if(currentDisplayOption == 1){
            settingsScreen.normalFontColor =  Constants.FONT_COLOR_NORMAL_LIGHT
            settingsScreen.fontColorOnClickingOptions =  Constants.FONT_COLOR_ON_CLICKING_OPTIONS_LIGHT
            settingsScreen.settingsHighlight = Constants.IMG_NAV_ARROW_LIGHT
        }
        else if(currentDisplayOption == 0){
            settingsScreen.normalFontColor =  Constants.FONT_COLOR_NORMAL_DARK
            settingsScreen.fontColorOnClickingOptions =  Constants.FONT_COLOR_ON_CLICKING_OPTIONS_DARK
            settingsScreen.settingsHighlight = Constants.IMG_NAV_ARROW_DARK
        }

        displayOptionsRect .isDisplayOptionsSelected = false
        displayOptionsRect.focus = false
        displayRect.focus = true
        displayHighlight.visible = true
        isUnitsTextSelected = true
        isSoundTextSelected = true
        isRegenTextSelected = true
        isBluetoothTextSelected = true
        isRideTextSelected = true
        unitsOptionsRect.isUnitsOptionsTextSelected = true
        soundOptionsRect.isSoundOptionsTextSelected = true
        regenOptionsRect.isRegenOptionsTextSelected = true
        rideOptionsRect.isRideOptionsTextSelected = true
        btOptionsRect.isBTOptionsTextSelected = true
        //console.log("return key pressed");
    }
}
