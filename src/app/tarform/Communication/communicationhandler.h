/********************************************************************************
*
* Name:  communicationhandler.h
*
* Copyright (c) Claysol Media Labs.
*
* This file is part of Tarform App Cluster.
*
* Description:
*
*
*
* Author	Nibedit Dey
* Date      06 May 2019
********************************************************************************/

#ifndef COMMUNICATIONHANDLER_H
#define COMMUNICATIONHANDLER_H

#include <QObject>
#include <QPointer>
#include "cantransreceiver.h"

class CommunicationHandler: public QObject
{
    Q_OBJECT
    Q_PROPERTY(int speed READ speed NOTIFY speedChanged)
    Q_PROPERTY(int vehicleRPM READ vehicleRPM NOTIFY vehicleRPMChanged)
    Q_PROPERTY(int motorTorque READ motorTorque NOTIFY motorTorqueChanged)
    Q_PROPERTY(bool ledStatus READ ledStatus NOTIFY ledStatusChanged)
    Q_PROPERTY(bool temperatureWarning READ temperatureWarning NOTIFY temperatureWarningChanged)
    Q_PROPERTY(int batteryState READ batteryState NOTIFY batteryStateChanged)
    Q_PROPERTY(int batteryTripDistance READ batteryTripDistance NOTIFY batteryTripDistanceChanged)
    Q_PROPERTY(float odometer READ odometer NOTIFY odometerChanged)
    Q_PROPERTY(int motorTemp READ motorTemp NOTIFY motorTempChanged)
    Q_PROPERTY(int controllerTemp READ controllerTemp NOTIFY controllerTempChanged)
    Q_PROPERTY(bool leftIndicator READ leftIndicator NOTIFY leftIndicatorChanged)
    Q_PROPERTY(bool rightIndicator READ rightIndicator NOTIFY rightIndicatorChanged)
    Q_PROPERTY(int power READ power NOTIFY powerChanged)
    Q_PROPERTY(int batteryADAP READ batteryADAP NOTIFY batteryADAPChanged)

public:
    CommunicationHandler(QObject* parent = nullptr);

    int speed() const { return  m_nSpeed;}
    int vehicleRPM() const { return  m_nRPM;}
    int motorTorque() const { return  m_nTorque;}
    bool ledStatus() const { return  m_isLEDon;}
    int temperatureWarning() const { return  m_isTempError;}
    int batteryState() const { return  m_nBatteryState;}
    int batteryTripDistance() const { return  m_nBatteryTripDistance;}
    float odometer() const { return  m_fOdometer;}
    int motorTemp() const { return  m_nMotorTemp;}
    int controllerTemp() const { return  m_nControllerTemp;}
    bool leftIndicator() { return m_isLeftIndicatorOn; }
    bool rightIndicator() { return m_isRightIndicatorOn; }
    bool power() { return m_nPower; }
    int batteryADAP() { return m_nBatteryADAP;}

signals:
    void speedChanged(int);
    void vehicleRPMChanged(int);
    void motorTorqueChanged(int);
    void ledStatusChanged(bool);
    void temperatureWarningChanged(bool);
    void batteryStateChanged(int);
    void batteryTripDistanceChanged(int);
    void odometerChanged(float);
    void motorTempChanged(int);
    void controllerTempChanged(int);
    void leftIndicatorChanged(bool);
    void rightIndicatorChanged(bool);
    void powerChanged(int);
    void batteryADAPChanged(int);

private slots:
    void handleSpeedChanged(int);
    void handleVehicleRPMChanged(int);
    void handleMotorTorqueChanged(int);
    void handleLedStatusChanged(bool);
    void handleTemperatureWarningChanged(bool);
    void handleBatteryStateChanged(int);
    void handleBatteryTripDistanceChanged(int);
    void handleOdometerChanged(float);
    void handleMotorTempChanged(int);
    void handleControllerTempChanged(int);
    void handleLeftIndicatorChanged(bool);
    void handleRightIndicatorChanged(bool);
    void handlePowerChanged(int);
    void handleBatteryADAPChanged(int);

private:
    int m_nSpeed = 0;
    int m_nRPM = 0;
    int m_nTorque = 0;
    int m_nBatteryState = 0;
    int m_nBatteryTripDistance = 0;
    float m_fOdometer = 0;
    int m_nMotorTemp = 0;
    int m_nControllerTemp = 0;
    int m_nPower = 0;
    int m_nBatteryADAP = 0;
    bool m_isTempError = false;
    bool m_isLEDon = false;
    bool m_isLeftIndicatorOn = false;
    bool m_isRightIndicatorOn = false;
    QPointer <CANTransreceiver> m_pCANListener = nullptr;
};

#endif // COMMUNICATIONHANDLER_H
