#include "communicationhandler.h"
//#include <QDebug>

CommunicationHandler::CommunicationHandler(QObject *parent): QObject(parent)
{
    m_pCANListener = new CANTransreceiver(this);
    if(m_pCANListener)
    {
        connect( m_pCANListener, SIGNAL(speedChanged(int)), this, SLOT(handleSpeedChanged(int)));
        connect( m_pCANListener, SIGNAL(vehicleRPMChanged(int)), this, SLOT(handleVehicleRPMChanged(int)));
        connect( m_pCANListener, SIGNAL(motorTorqueChanged(int)), this, SLOT(handleMotorTorqueChanged(int)));
        connect( m_pCANListener, SIGNAL(ledStatusChanged(bool)), this, SLOT(handleLedStatusChanged(bool)));
        connect( m_pCANListener, SIGNAL(temperatureWarningChanged(bool)), this, SLOT(handleTemperatureWarningChanged(bool)));
        connect( m_pCANListener, SIGNAL(batteryStateChanged(int)), this, SLOT(handleBatteryStateChanged(int)));
        connect( m_pCANListener, SIGNAL(batteryTripDistanceChanged(int)), this, SLOT(handleSpeedChanged(int)));
        connect( m_pCANListener, SIGNAL(odometerChanged(float)), this, SLOT(handleOdometerChanged(float)));
        connect( m_pCANListener, SIGNAL(motorTempChanged(int)), this, SLOT(handleMotorTempChanged(int)));
        connect( m_pCANListener, SIGNAL(controllerTempChanged(int)), this, SLOT(handleControllerTempChanged(int)));
        connect( m_pCANListener, SIGNAL(leftIndicatorChanged(bool)), this, SLOT(handleLeftIndicatorChanged(bool)));
        connect( m_pCANListener, SIGNAL(rightIndicatorChanged(bool)), this, SLOT(handleRightIndicatorChanged(bool)));
        connect( m_pCANListener, SIGNAL(powerChanged(int)), this, SLOT(handlePowerChanged(int)));
        connect( m_pCANListener, SIGNAL(batteryADAPChanged(int)), this, SLOT(handleBatteryADAPChanged(int)));
    }
    else
    {
        //qDebug()<<"CANTransreceiver failed to load";
    }
}

void CommunicationHandler::handleSpeedChanged(int nSpeed)
{
    m_nSpeed = nSpeed;
    emit speedChanged(m_nSpeed);
    //qDebug() << "Speed Changed: "<< m_nSpeed;
}

void CommunicationHandler::handleVehicleRPMChanged(int nRPM)
{
    m_nRPM = nRPM;
    emit vehicleRPMChanged(m_nRPM);
    //qDebug() << "vehicleRPM Changed :"<<m_nRPM;
}

void CommunicationHandler::handleMotorTorqueChanged(int nTorque)
{
    m_nTorque = nTorque;
    emit motorTorqueChanged(m_nTorque);
    //qDebug() << "motorTorque Changed: "<<m_nTorque;
}

void CommunicationHandler::handleLedStatusChanged(bool isLEDon)
{
    m_isLEDon = isLEDon;
    emit ledStatusChanged(m_isLEDon);
    //qDebug() << "LedStatus Changed: "<<m_isLEDon;
}

void CommunicationHandler::handleTemperatureWarningChanged(bool isTempError)
{
    m_isTempError = isTempError;
    emit temperatureWarningChanged(m_isTempError);
    //qDebug() << "Temp Indicator Changed: "<<m_isTempError;
}

void CommunicationHandler::handleBatteryStateChanged(int nBatteryState)
{
    m_nBatteryState = nBatteryState;
    emit batteryStateChanged(m_nBatteryState);
    //qDebug() << "BatteryState Changed: "<<m_nBatteryState;
}

void CommunicationHandler::handleBatteryTripDistanceChanged(int nBatteryTripDistance)
{
    m_nBatteryTripDistance = nBatteryTripDistance;
    emit batteryTripDistanceChanged(m_nBatteryTripDistance);
    //qDebug() << "BatteryTripDustance Changed: "<<m_nBatteryTripDistance;
}

void CommunicationHandler::handleOdometerChanged(float fOdometer)
{
    m_fOdometer = fOdometer;
    emit odometerChanged(m_fOdometer);
    //qDebug() << "Odometer Changed: "<<m_fOdometer;
}

void CommunicationHandler::handleMotorTempChanged(int nMotorTemp)
{
    m_nMotorTemp = nMotorTemp;
    emit motorTempChanged(m_nMotorTemp);
    //qDebug() << "MotorTemp Changed: "<<m_nMotorTemp;
}

void CommunicationHandler::handleControllerTempChanged(int nControllerTemp)
{
    m_nControllerTemp = nControllerTemp;
    emit controllerTempChanged(m_nControllerTemp);
    //qDebug() << "ControllerTemp Changed: "<<m_nControllerTemp;
}

void CommunicationHandler::handleLeftIndicatorChanged(bool isLeftOn)
{
    m_isLeftIndicatorOn = isLeftOn;
    emit leftIndicatorChanged(m_isLeftIndicatorOn);
    //qDebug() << "Left Indicator Changed: "<<m_isLeftIndicatorOn;
}
void CommunicationHandler::handleRightIndicatorChanged(bool isRightOn)
{
    m_isRightIndicatorOn = isRightOn;
    emit rightIndicatorChanged(m_isRightIndicatorOn);
    //qDebug() << "Right Indicator Changed: "<<m_isRightIndicatorOn;
}
void CommunicationHandler::handlePowerChanged(int nPower)
{
    m_nPower = nPower;
    emit powerChanged(m_nPower);
    //qDebug() << "Power Changed: "<<m_nPower;
}

void CommunicationHandler::handleBatteryADAPChanged(int nBatteryADAP)
{
    m_nBatteryADAP = nBatteryADAP;
    emit batteryADAPChanged(m_nBatteryADAP);
    //qDebug() << "ADAP Changed: "<<m_nBatteryADAP;
}
