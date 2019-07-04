/********************************************************************************
*
* Name: HomeScreen.qml
*
* Copyright (c) Claysol Media Labs.
*
* This file is part of Tarform App Cluster.
*
* Description:
*       HomeScreen Page
*
*
* Author	Lavanya-CP/Nibedit Dey
* Date      11 Mar 2019
********************************************************************************/
//Import modules and files
import QtQuick 2.9
import QtQuick.Controls 2.2
import Tarform.Elements 1.0
import "Constants.js" as Constants

Item {
    id: root

    //Property declarations
    property int odometerValue: m_communicationHandler.odometer
    property real speed: m_communicationHandler.speed * 0.0625
    property real power: m_communicationHandler.power * 0.01
    property int throttleValue: 212// Power Ring default at 0 power
    property bool isLeftIndicatorON: m_communicationHandler.leftIndicator
    property bool isRightIndicatorON: m_communicationHandler.rightIndicator
    property bool isHighBeamON: m_communicationHandler.ledStatus
    property bool isTemperatureError: m_communicationHandler.temperatureWarning
    property int units : userSettings.readUnits() //Retrieve from Settings Utility
    property int mode : userSettings.readRideMode()//Retrieve from Settings Utility

    property string ecoModeFontColor: (0 === userSettings.readDisplayMode())? Constants.HOME_MODE_FONT_COLOR_DARK : Constants.FONT_COLOR_NORMAL_LIGHT
    property string modeFontColor: (0 === userSettings.readDisplayMode())? Constants.FONT_COLOR_NORMAL_DARK : Constants.FONT_COLOR_NORMAL_LIGHT
    property string speedFontColor: (0 === userSettings.readDisplayMode())? Constants.FONT_COLOR_NORMAL_DARK : Constants.SPEEDOMETER_FONT_COLOR_LIGHT
    property string unitsFontColor: (0 === userSettings.readDisplayMode())? Constants.HOME_UNIT_FONT_COLOR_DARK : Constants.FONT_COLOR_NORMAL_LIGHT
    property string odometerFontColor: (0 === userSettings.readDisplayMode())? Constants.FONT_COLOR_NORMAL_DARK : Constants.FONT_COLOR_NORMAL_LIGHT

    property string temperatureIcon: (0 === userSettings.readDisplayMode())? Constants.IMG_TEMPERATURE_DARK : Constants.IMG_TEMPERATURE_LIGHT
    property string beamIcon: (0 === userSettings.readDisplayMode())? Constants.IMG_HIGH_BEAM_DARK : Constants.IMG_HIGH_BEAM_LIGHT
    property string leftIndicatorIcon: (0 === userSettings.readDisplayMode())? Constants.IMG_TURN_LEFT_DARK : Constants.IMG_TURN_LEFT_LIGHT
    property string rightIndicatorIcon: (0 === userSettings.readDisplayMode())? Constants.IMG_TURN_RIGHT_DARK : Constants.IMG_TURN_RIGHT_LIGHT

    //Object properties
    objectName: "homeScreen"
    Accessible.name: objectName
    width: Constants.SCREEN_WIDTH
    height: Constants.SCREEN_HEIGHT

    onPowerChanged: {
        if(power>0) {
            throttleValue = 212 - (212/power)
        } else {
            throttleValue = 359 - (359/power)
        }

        powerRing.setSpanAngle(throttleValue)
    }

    onSpeedChanged: {
        //console.log("Speed:",speed)
        m_audioHandler.handleSpeedChanged(Math.ceil(speed));
    }

    function convertDistance(distance) {
        distance = Math.round( distance * 10 ) / 10;
        return distance;
    }

    //Child objects

    SettingsUtility {
        id: userSettings
    }

    FontLoader { id: fontMdCn; source: "qrc:/fonts/MdCn" }
    FontLoader { id: fontDemiCn; source: "qrc:/fonts/DemiCn" }
    FontLoader { id: fontXLtCn; source: "qrc:/fonts/XLtCn" }

    Image {
        id: imageItem
        width:800
        height:800
        source: Constants.IMG_POWER_RING
        visible: true

        PowerRing {
            id: powerRing
            anchors {
                centerIn: parent
                fill: parent
            }
            startAngle: 0
            spanAngle: 360
            thickness: 60
            Image {
                id: outerRing
                anchors.fill:parent
                source: Constants.IMG_OUTER_RING
            }
        }
    }
    //!Power Ring

    //Startup self-test
    //                SequentialAnimation on speed{
    //                    NumberAnimation{ from: 0; to:100; duration: 20000 }
    //                    PauseAnimation {duration: 1000}
    //                    NumberAnimation{from:100;to: 0; duration: 4000}
    //                }
    //!Startup self-test

    Item{
        id:speedLabel
        height: 320
        width: 490
        anchors.centerIn: parent

        Text {
            id: speedText
            font{
                pixelSize: Constants.SPEEDOMETER_FONT_SIZE;
                family: fontXLtCn.name;
                weight: Font.ExtraLight;
            }
            clip: true
            anchors.fill: speedLabel
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: speedFontColor
            text:(0 == root.units) ? Math.ceil(speed*0.6213) : Math.ceil(speed)
        }
    }

    Image {
        id: leftIndicator
        source: leftIndicatorIcon
        x:speedLabel.x - 85
        y:speedLabel.y

        SequentialAnimation on x {
            loops: Animation.Infinite
            PropertyAnimation {to: (speedLabel.x - 100);duration: 300  }
        }

        Timer{
            id: leftIndicatorTimer
            interval: 300
            running: leftIndicator.visible
            repeat: true
            onTriggered: if(root.isLeftIndicatorON){
                             leftIndicator.opacity = (leftIndicator.opacity === 0) ? 1 : 0
                         }
        }
        visible: root.isLeftIndicatorON
    }

    Image {
        id: rightIndicator
        source: rightIndicatorIcon
        x:speedLabel.x + 500
        y:speedLabel.y

        SequentialAnimation on x {
            loops: Animation.Infinite
            PropertyAnimation { to: (speedLabel.x + 515);duration: 300 }
        }

        Timer{
            id: rightIndicatorTimer
            interval: 300
            running: rightIndicator.visible
            repeat: true
            onTriggered: if(root.isRightIndicatorON){
                             rightIndicator.opacity = rightIndicator.opacity === 0 ? 1 : 0
                         }
        }
        visible: root.isRightIndicatorON
    }

    Text {
        id: unitLabel
        anchors{
            top: speedLabel.bottom
            horizontalCenter: parent.horizontalCenter
        }
        text: (0 === root.units) ? "MPH" : "KPH"
        font{
            pixelSize: Constants.ODOMETER_FONT_SIZE
            letterSpacing:Constants.HOME_UNIT_LETTER_SPACING
            family: fontDemiCn.name
        }
        color: unitsFontColor
    }

    Item{
        id: drivingMode
        height: 60
        width: 365
        anchors{
            horizontalCenter: root.horizontalCenter
            bottom: speedLabel.top
            bottomMargin: 100
        }

        Text {
            id:drivingModeText
            text: switch(root.mode) {
                  case 0: text = "ECO";
                      color= ecoModeFontColor;
                      break;
                  case 1: text = "STANDARD";
                      color= modeFontColor;
                      break;
                  case 2: text = "SPORT";
                      color= modeFontColor;
                      break;
                  }
            clip: true
            anchors.fill:drivingMode
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font{
                pixelSize: Constants.ODOMETER_FONT_SIZE
                letterSpacing: Constants.HOME_MODE_LETTER_SPACING
                family: fontMdCn.name
            }
        }
    }

    Image {
        id: highBeam
        visible: !root.isHighBeamON
        source: beamIcon
        anchors{
            horizontalCenter: parent.horizontalCenter
            top:unitLabel.bottom
        }
    }

    BatteryStatistics{
        id:battery
        batteryLevel: m_communicationHandler.batteryADAP*0.5
    }

    Image {
        id: temp
        visible:isTemperatureError
        anchors{
            bottom: speedLabel.top
            left: drivingMode.right
            leftMargin: -20
        }
        source: temperatureIcon
    }

    Text {
        id: odometerText
        property real odometerConvertedValue : (0 === root.units)? (root.odometerValue*0.00390625*0.6213) : root.odometerValue*0.00390625
        text: (0 === root.units)? convertDistance(odometerConvertedValue) +"M" : convertDistance(odometerConvertedValue) +"K"
        font{
            pixelSize: Constants.ODOMETER_FONT_SIZE
            letterSpacing: Constants.HOME_ODOMETER_LETTER_SPACING
            family: fontMdCn.name
        }
        color: odometerFontColor
        anchors {
            top: speedLabel.bottom
            left: speedLabel.right
            topMargin: 100
            leftMargin: -110
        }
        transform: Rotation { origin.x: 30; origin.y: 30; angle: -30}
    }
}

