/********************************************************************************
*
* Name: root.qml
*
* Copyright (c) Claysol Media Labs.
*
* This file is part of Tarform App Cluster.
*
* Description:
*       Charging Screen
*
*
* Author	Nibedit Dey
* Date      11 Mar 2019
********************************************************************************/
//Import modules and files
import QtQuick 2.9
import QtQuick.Extras 1.4
import Tarform.Elements 1.0
import QtQuick.Controls.Styles 1.4
import "Constants.js" as Constants

Item {
    id: root

    //Property declarations
    property real batteryChargeLevel:m_communicationHandler.batteryState * 0.5
    property int remainingChargingTime: 2 //TODO
    property int chargeLevel: 100- m_communicationHandler.batteryState

    property string normalFontColor: (0 === userpreferences.readDisplayMode())? Constants.FONT_COLOR_NORMAL_DARK : Constants.FONT_COLOR_NORMAL_LIGHT
    property string percentChargeFontColor: (0 === userpreferences.readDisplayMode())? Constants.FONT_COLOR_NORMAL_DARK : Constants.CHARGING_PERCENTAGE_FONT_COLOR_LIGHT

    property string fadedLargeDot:(0 === userpreferences.readDisplayMode()) ? Constants.IMG_FADED_LARGE_DOT_DARK : Constants.IMG_FADED_LARGE_DOT_LIGHT
    property string solodLargeDot: (0 === userpreferences.readDisplayMode()) ?Constants.IMG_SOLID_LARGE_DOT_DARK : Constants.IMG_SOLID_LARGE_DOT_LIGHT

    //Object properties
    objectName: "chargingScreen"
    Accessible.name: objectName
    width: Constants.SCREEN_WIDTH
    height: Constants.SCREEN_HEIGHT

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

    CircularGauge {
        id: gauge
        minimumValue: 0
        maximumValue: 100
        width: Constants.SCREEN_WIDTH
        height: Constants.SCREEN_HEIGHT
        stepSize: 10
        style: CircularGaugeStyle {
            id: gaugeStyle
            needle: null
            foreground: null
            minorTickmark: null
            background:null
            tickmark: null
            needleRotation: root.batteryChargeLevel
            minimumValueAngle: -90
            maximumValueAngle: 90
            tickmarkLabel:Image {
                id: dots
                source: (styleData.value>=needleRotation)&&(needleRotation!==100)? fadedLargeDot : solodLargeDot
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.verticalCenter
            }
        }

        Text {
            id: text1
            y: 206
            text: qsTr("CHARGING")
            anchors.horizontalCenterOffset: 1
            font{
                pixelSize: Constants.CHARGING_FONT_SIZE
                letterSpacing: Constants.CHARGING_TITLE_LETTER_SPACING
                family: fontMdCn.name
            }
            color: normalFontColor
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            anchors.fill:parent
            text: Math.ceil(root.batteryChargeLevel)+ "%"
            font{
                pixelSize: Constants.CHARGING_PERCENTAGE_FONT_SIZE
                family: fontXLtCn.name
                weight: Font.ExtraLight;
            }
            color:percentChargeFontColor
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            x: 0
            y: 657
            width: parent.width
            text: root.chargeLevel+qsTr("% CHARGE IN ")+root.remainingChargingTime+"H"
            font{
                pixelSize: Constants.CHARGING_FONT_SIZE
                letterSpacing: Constants.CHARGING_LETTER_SPACING
                family: fontMdCn.name
            }
            color: normalFontColor
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Path {
            startX: 100;
            startY: 0
            PathArc {
                x: 0; y: 100
                radiusX: 100; radiusY: 100
                useLargeArc: true
            }
        }
    }
}
