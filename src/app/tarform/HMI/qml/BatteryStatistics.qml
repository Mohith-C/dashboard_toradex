/********************************************************************************
*
* Name: BatteryStatistics.qml
*
* Copyright (c) Claysol Media Labs.
*
* This file is part of Tarform App Cluster.
*
* Description:
*       BatteryStatistics Page
*
*
* Author	Lavanya-CP
* Date      11 Mar 2019
********************************************************************************/

//Import modules and files
import QtQuick 2.9
import QtQuick.Extras 1.4
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import Tarform.Elements 1.0
import "Constants.js" as Constants

Item {
    id: root

    //Property declarations
    property real batteryLevel: m_communicationHandler.batteryADAP * 0.5
    property string percTextBelow10: (0 === userSettings.readDisplayMode()) ? Constants.FONT_COLOR_LOW_DARK : Constants.FONT_COLOR_NORMAL_LIGHT
    property string percTextAbove10: (0 === userSettings.readDisplayMode()) ? Constants.FONT_COLOR_NORMAL_DARK : Constants.FONT_COLOR_NORMAL_LIGHT

    property string fadedSmallDotRed: (0 === userSettings.readDisplayMode()) ? Constants.IMG_SOLID_SMALL_DOT_RED_DARK : Constants.IMG_FADED_SMALL_DOT_LIGHT
    property string fadedSmallDot: (0 === userSettings.readDisplayMode()) ? Constants.IMG_FADED_SMALL_DOT_DARK : Constants.IMG_FADED_SMALL_DOT_LIGHT
    property string solidSmallDot: (0 === userSettings.readDisplayMode()) ? Constants.IMG_SOLID_SMALL_DOT_DARK :Constants.IMG_SOLID_SMALL_DOT_LIGHT

    //        SequentialAnimation on batteryLevel {
    //            NumberAnimation{from: 0 ; to:100 ; duration: 20000}
    //        }

    //Object properties
    objectName: "batteryStatistics"
    Accessible.name: objectName
    width: Constants.SCREEN_WIDTH
    height: Constants.SCREEN_HEIGHT

    //Child objects
    Item{
        id: batteryIndicatorRect
        width: 200
        height:50
        anchors.horizontalCenter: parent.horizontalCenter
        y:703

        Image {
            id: dot1
            source:(batteryLevel<=10)? fadedSmallDotRed : solidSmallDot
            anchors{
                left: parent.left
                leftMargin: 4
                top: parent.top
                topMargin: 2
            }
        }

        Image {
            id: dot2
            source:(batteryLevel<=20)? fadedSmallDot : solidSmallDot
            anchors{
                left: dot1.right
                leftMargin: 16
                top: parent.top
                topMargin: 16
            }
        }

        Image {
            id: dot3
            source:(batteryLevel<=40)? fadedSmallDot : solidSmallDot
            anchors{
                top: parent.top
                topMargin: 22
                horizontalCenter: parent.horizontalCenter
            }
        }

        Image {
            id: dot4
            source:(batteryLevel<=60)? fadedSmallDot : solidSmallDot
            anchors{
                right: dot5.left
                rightMargin: 16
                top: parent.top
                topMargin: 16
            }
        }

        Image {
            id: dot5
            source:(batteryLevel<=80)? fadedSmallDot : solidSmallDot
            anchors{
                right: parent.right
                rightMargin: 4
                top: parent.top
                topMargin: 2
            }
        }
    }

    Text {
        id: batteryPercTexts
        x: 190
        y: 640
        horizontalAlignment: Text.AlightRight
        text: Math.ceil(root.batteryLevel) +"%"
        transform: Rotation { origin.x: 30; origin.y: 30; angle: 34}
        color:(batteryLevel<=10)? percTextBelow10 : percTextAbove10
        font{
            pixelSize: Constants.BATTERY_PERCENT_FONT_SIZE
            family: fontMdCn.name
            letterSpacing: Constants.BATTERY_PERCENT_LETTER_SPACING
        }
    }
}











