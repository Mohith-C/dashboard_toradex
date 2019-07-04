/********************************************************************************
*
* Name: BatteryStatistics.qml
*
* Copyright (c) Claysol Media Labs.
*
* This file is part of Tarform App Cluster.
*
* Description:
*       main.qml
*
*
* Author	Nibedit Dey
* Date      11 Mar 2019
********************************************************************************/

//Import modules and files
import QtQuick 2.9
import QtQuick.Controls 2.2
import Tarform.Elements 1.0

ApplicationWindow {
    id: root

    //Object properties
    visible: true
    width: 800
    height: 800
    title: "Tarform"
    color: "black"

    //Child objects
    Item {
        id: mainRect
        anchors.fill:parent

        Loader {
            id: screenLoader
            focus: true
            anchors.fill: parent
            sourceComponent: homeScreenComponent
            active: true
        }

        Component {
            id: homeScreenComponent
            HomeScreen {
                id: homeScreen
            }
        }

        Component {
            id: settingsScreenComponent
            SettingsScreen {
                id: settingsScreen
            }
        }
        Component {
            id: chargingScreenComponent
            ChargingScreen {
                id: chargingScreen
            }
        }
        //Handle KeyNavigation
        function leftKeyPressed() {
            if(screenLoader.sourceComponent === homeScreenComponent){
                screenLoader.sourceComponent = settingsScreenComponent;
            }
            else if(screenLoader.sourceComponent === chargingScreenComponent){
                screenLoader.sourceComponent = homeScreenComponent;
            }
            else if(screenLoader.sourceComponent === settingsScreenComponent){
                screenLoader.sourceComponent = chargingScreenComponent
            }
        }
        function rightKeyPressed() {
            if(screenLoader.sourceComponent === settingsScreenComponent){
                screenLoader.sourceComponent= homeScreenComponent
            }
            else if(screenLoader.sourceComponent === homeScreenComponent){
                screenLoader.sourceComponent = chargingScreenComponent
            }
            else if(screenLoader.sourceComponent === chargingScreenComponent){
                screenLoader.sourceComponent = settingsScreenComponent;
            }
        }

        Keys.onPressed: {
            switch (event.key) {
            case Qt.Key_Left:
                leftKeyPressed();
                break;
            case Qt.Key_Right :
                rightKeyPressed();
                break;
            default:
                break;
            }
        }
        //!Handle KeyNavigation
    }
}




