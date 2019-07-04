#include "cantransreceiver.h"
#include <QCanBus>
#include <QVariant>

CANTransreceiver::CANTransreceiver(QObject *parent) : QObject(parent)
{
    //qDebug()<<"Invoking connectCanDevice()\n";
    connectCANdevice();
}


CANTransreceiver:: ~CANTransreceiver()
{
    disconnectCANdevice();
}


bool CANTransreceiver::connectCANdevice()
{

    QString errorString= "";
    bool isConnected = false;

    if (QCanBus::instance()->plugins().contains(QStringLiteral("socketcan")))
    {

        //qDebug()<<"CAN socket plugin Available.\n";
        m_pCANBUSDevice = QCanBus::instance()->createDevice(QStringLiteral("socketcan"),
                                                            QStringLiteral("can1"),
                                                            &errorString);
        if (!m_pCANBUSDevice)
        {
            //qDebug() << "connectCANdevice() FAILED. Error Message : " << errorString<< "\n";
            return isConnected;
        }

        //qDebug() << "connectCANdevice() SUCCESS\n";

        connect(m_pCANBUSDevice, &QCanBusDevice::framesReceived,this, &CANTransreceiver::receiveCANdata);

        connect(m_pCANBUSDevice, &QCanBusDevice::errorOccurred, this, &CANTransreceiver::receiveError);

    }
    //TODO: Uncomment below line to set at 500kbps. Below configuration doesn't work with peakcan.
    //m_pCANBUSDevice->setConfigurationParameter(QCanBusDevice::BitRateKey, QVariant(500000));
    m_pCANBUSDevice->connectDevice();
    //qDebug() << "Done connectCANdevice() \n";

    return true;
}

void CANTransreceiver::receiveCANdata()
{
    int data_len;
    QByteArray sData_p;

    if (!m_pCANBUSDevice)
        return;

    ////qDebug()<<"Frame received : Entering receiveCANdata() \n";
    m_Mutex.lock();
    m_moreFrames = m_pCANBUSDevice->framesAvailable();
    m_Mutex.unlock();

    while (m_moreFrames)
    {
        m_CANBUSFrame = m_pCANBUSDevice->readFrame();

        switch (m_CANBUSFrame.frameType())
        {
        case QCanBusFrame::DataFrame:
        {
            //qDebug()<<"Data Frame Type\n";
            quint32 frame_id = m_CANBUSFrame.frameId();
            data_len = m_CANBUSFrame.payload().size();
            sData_p = m_CANBUSFrame.payload();
            //qDebug()<<"Data: Payload: "<<sData_p;

            processInwardData(sData_p,frame_id,data_len);

            break;
        }
        case QCanBusFrame::UnknownFrame:
        {
            //qDebug()<<"Unknown Frame\n";
            break;
        }
        case QCanBusFrame::ErrorFrame:
        {
            QString errMsg = m_pCANBUSDevice->interpretErrorFrame(m_CANBUSFrame);
            //qDebug() << errMsg;
            break;
        }
        case QCanBusFrame::InvalidFrame:
        {
            //qDebug()<<"Invalid Frame\n";
            break;
        }
        case QCanBusFrame::RemoteRequestFrame:
        {
            //qDebug()<<"Remote Request Frame\n";
            break;
        }
        }

        m_Mutex.lock();
        m_moreFrames = m_pCANBUSDevice->framesAvailable();
        m_Mutex.unlock();
    }
}

void CANTransreceiver::processInwardData(QByteArray byteData, quint32 frameID, int nDataLength)
{
    //qDebug()<<"Entering processInwardData() : \n";
    //qDebug()<<"Frame ID : "<<frameID<<"\n";
    //qDebug()<<"Data Length : "<<nDataLength<<"\n";

    Q_UNUSED(nDataLength);

    switch(frameID)
    {
    case kFRAMEID_SPEED:
    {
        processSpeedInfo(byteData);
        break;
    }
    case kFRAMEID_BATTERY_TEMP:
    {
        processBatteryTempInfo(byteData);
        break;
    }
    case kFRAMEID_LED_STATUS:
    {
        processLEDInfo(byteData);
        break;
    }
    case kFRAMEID_ODOMETER:
    {
        processOdometerInfo(byteData);
        break;
    }
    case kFRAMEID_POWER:
    {
        processPowerInfo(byteData);
        break;
    }
    case kBATTERY_INFO:
    {
        processBatteryInfo(byteData);
        break;
    }
    default:
    {
        //qDebug()<<"Data not handled : "<<byteData<<"\n";
        break;
    }
    }
    //qDebug()<<"Leaving processInwardData()\n";
}


void CANTransreceiver::sendCANdata(int nData, quint32 frameID, int nFrameType)
{

    QCanBusFrame frame;

    if (!m_pCANBUSDevice)
        return;

    // Check for DATA Frame
    QByteArray byteData;
    byteData[0] = char(nData);

    frame.setPayload(byteData);
    frame.setFrameId(frameID);

    switch(nFrameType)
    {
    case QCanBusFrame::RemoteRequestFrame:
    {
        frame.setFrameType(QCanBusFrame::RemoteRequestFrame);
        break;
    }
    case QCanBusFrame::ErrorFrame:
    {
        frame.setFrameType(QCanBusFrame::ErrorFrame);
        break;
    }
    case QCanBusFrame::DataFrame:
    {
        frame.setFrameType(QCanBusFrame::DataFrame);
        break;
    }
    }

    //qDebug()<<"sendCANdata: Sending CAN Frame\n";
    m_pCANBUSDevice->writeFrame(frame);
}


void CANTransreceiver::receiveError(QCanBusDevice::CanBusError error) const
{
    switch (error)
    {
    case QCanBusDevice::ReadError:
    {
        //qDebug() << "ReadError : " + m_pCANBUSDevice->errorString();
        break;
    }
    case QCanBusDevice::WriteError:
    {
        //qDebug() << "WriteError : " + m_pCANBUSDevice->errorString();
        break;
    }
    case QCanBusDevice::ConnectionError:
    {
        //qDebug() << "ConnectionError : " + m_pCANBUSDevice->errorString();
        break;
    }
    case QCanBusDevice::ConfigurationError:
    {
        //qDebug() << "ConfigurationError : " + m_pCANBUSDevice->errorString();
        break;
    }
    case QCanBusDevice::UnknownError:
    {
        //qDebug() << "UnknownError : " + m_pCANBUSDevice->errorString();
        break;
    }
    case QCanBusDevice::NoError:
        break;
    }
}


void CANTransreceiver::setParams(int key, int value)
{
    Q_UNUSED(key)
    Q_UNUSED(value)

    QString sData= "";
    int nframe = 0;

    sendCANdata(nframe,m_frameID,1);

}



void CANTransreceiver::disconnectCANdevice()
{
    if (!m_pCANBUSDevice)
        return;

    m_pCANBUSDevice->disconnectDevice();
    delete m_pCANBUSDevice;
    m_pCANBUSDevice = nullptr;
}


void CANTransreceiver::processSpeedInfo(QByteArray byteData)
{
    int speed = byteData[1]<<8 |byteData[0];//decimal
    //qDebug()<<"Emitting speed : "<<speed<<"\n";
    //speed_in_kph = speed * 0.0625;
    //This will be handled based on units selection in Settings
    emit speedChanged(speed);

    int rpm = byteData[3]<<8 |byteData[2];//decimal
    //qDebug()<<"Emitting RPM : "<<rpm<<"\n";
    emit vehicleRPMChanged(rpm);
}
void CANTransreceiver::processLEDInfo(QByteArray byteData)
{
    bool leftturn = byteData[0] & 0x01;
    bool rightturn = byteData[0] & 0x02;
    bool lowBeam = byteData[0] & 0x04;

    emit leftIndicatorChanged(leftturn);
    emit rightIndicatorChanged(rightturn);
    emit ledStatusChanged(lowBeam);
}

void CANTransreceiver::processOdometerInfo(QByteArray byteData)
{

    //Read 0-3 bytes
    int odometer = byteData[3]<<24 |byteData[2]<<16 |byteData[1]<<8 |byteData[0];

    //odometer_in_kph = odometer * 0.00390625;
    //Odometer distance in km, in 24.8 format
    //This will be handled based on units selection in Settings
    //qDebug()<<"Emitting odometer status : "<<odometer<<"\n";
    emit odometerChanged(odometer);
}

void CANTransreceiver::processBatteryTempInfo(QByteArray byteData)
{
    int batteryHighTemp = byteData[0];
    int batteryAvgTemp = byteData[1];
    int batteryLowTemp = byteData[2];

    updateTemperatureIndicator(batteryHighTemp,kBATTERY_HIGH_TEMP);
    updateTemperatureIndicator(batteryAvgTemp,kBATTERY_AVG_TEMP);
    updateTemperatureIndicator(batteryLowTemp,kBATTERY_LOW_TEMP);
}


/*
BATTERY_HIGH_TEMP is above BATTERY_HIGH_TEMP_HI_THRESH, OR
BATTERY_HIGH_TEMP is below BATTERY_HIGH_TEMP_LO_THRESH, OR
BATTERY_AVG_TEMP is above BATTERY_AVG_TEMP_HI_THRESH, OR
BATTERY_AVG_TEMP is below BATTERY_AVG_TEMP_LO_THRESH, OR
BATTERY_LOW_TEMP is above BATTERY_LOW_TEMP_HI_THRESH, OR
BATTERY_LOW_TEMP is below BATTERY_LOW_TEMP_LO_THRESH, OR
MOTOR_TEMP is above MOTOR_TEMP_HI_THRESH, OR
MOTOR_TEMP is below MOTOR_TEMP_LO_THRESH, OR
CONTROLLER_SINK_TEMP is above CONTROLLER_SINK_TEMP_HI_THRESH, OR
CONTROLLER_SINK_TEMP is below CONTROLLER_SINK_TEMPP_LO_THRESH*/

void CANTransreceiver::updateTemperatureIndicator(int nTemperature, ETemperature eType)
{
    switch(eType)
    {
        case kBATTERY_HIGH_TEMP:
        {
            if ((nTemperature>BATTERY_HIGH_TEMP_HI_THRESH) || (nTemperature<BATTERY_HIGH_TEMP_LO_THRESH))
            {
                emit temperatureWarningChanged(true);
            }
            break;
        }
        case kBATTERY_AVG_TEMP:
        {
            if ((nTemperature>BATTERY_AVG_TEMP_HI_THRESH) || (nTemperature<BATTERY_AVG_TEMP_LO_THRESH))
            {
                emit temperatureWarningChanged(true);
            }
            break;
        }
        case kBATTERY_LOW_TEMP:
        {
            if ((nTemperature>BATTERY_LOW_TEMP_HI_THRESH) || (nTemperature<BATTERY_LOW_TEMP_LO_THRESH))
            {
                emit temperatureWarningChanged(true);
            }
            break;
        }
        case kMOTOR_HI_TEMP:
        case  kMOTOR_LOW_TEMP:
        {
            if ((nTemperature>MOTOR_TEMP_HI_THRESH) || (nTemperature<MOTOR_TEMP_LO_THRESH))
            {
                emit temperatureWarningChanged(true);
            }
            break;
        }

        case kSINK_HI_TEMP:
        case kSINK_LOW_TEMP:
        {
            if ((nTemperature>CONTROLLER_SINK_TEMP_HI_THRESH) || (nTemperature<CONTROLLER_SINK_TEMPP_LO_THRESH))
            {
                emit temperatureWarningChanged(true);
            }
            break;
        }
        default:
            break;
    }
}

void CANTransreceiver::processPowerInfo(QByteArray byteData)
{
    int voltage = byteData[1]<<8 |byteData[0];//decimal
    int current = byteData[3]<<8 |byteData[2];//decimal
    //Power is calculated as the product of BATTERY_VOLTAGE_MC (TPDO6, bytes 1­2) and BATTERY_CURRENT_MC
    int power = voltage * current;
    emit powerChanged(power);
}
void CANTransreceiver::processBatteryInfo(QByteArray byteData)
{
    int batteryInfo = byteData[0];
    emit batteryStateChanged(batteryInfo);

    int batteryADAP = byteData[1];
    emit batteryADAPChanged(batteryADAP);

}
