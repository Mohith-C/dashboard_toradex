/********************************************************************************
*
* Name:  icommunication.h
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
#ifndef ICOMMUNICATION_H
#define ICOMMUNICATION_H

#include <QObject>

class ICommunication
{
    public:
        virtual ~ICommunication(){}

    signals:
        virtual void speedChanged(int) = 0;
        virtual void vehicleRPMChanged(int) = 0;
        virtual void motorTorqueChanged(int) = 0;
        virtual void ledStatusChanged(bool) = 0;
        virtual void temperatureWarningChanged(bool) = 0;
        virtual void batteryStateChanged(int) = 0;
        virtual void batteryTripDistanceChanged(int) = 0;
        virtual void odometerChanged(float) = 0;
        virtual void motorTempChanged(int) = 0;
        virtual void controllerTempChanged(int) = 0;
        virtual void powerChanged(int) = 0;
        virtual void leftIndicatorChanged(bool) = 0;
        virtual void rightIndicatorChanged(bool) = 0;
        virtual void batteryADAPChanged(int) = 0;
};

Q_DECLARE_INTERFACE(ICommunication, "ICommunication")
#endif // ICOMMUNICATION_H
