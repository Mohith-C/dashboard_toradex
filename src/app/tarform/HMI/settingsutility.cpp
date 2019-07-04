#include <QSettings>
#include <QProcess>
#include "settingsutility.h"
#include <fcntl.h>
#include <unistd.h>

SettingsUtility::SettingsUtility(QObject *parent) : QObject(parent)
{

}

void SettingsUtility::saveRideMode(int nSettings)
{
    m_settings.setValue("ridemode",nSettings);
}

int SettingsUtility::readRideMode(void)
{

     int ridemode = m_settings.value("ridemode").toInt();
     return ridemode;
}

void SettingsUtility::saveUnits(int nSettings)
{
     m_settings.setValue("units",nSettings);
}

int SettingsUtility::readUnits(void)
{
    int units = m_settings.value("units").toInt();
    return units;
}

void SettingsUtility::saveSoundMode(int nSettings)
{
    m_settings.setValue("soundmode",nSettings);
}

int SettingsUtility::readSoundMode(void)
{
    int soundmode = m_settings.value("soundmode").toInt();
    return soundmode;
}

void SettingsUtility::saveRegenMode(int nSettings)
{
    m_settings.setValue("regen",nSettings);
}

int SettingsUtility::readRegenMode(void)
{
    int regen = m_settings.value("regen").toInt();
    return regen;
}

void SettingsUtility::saveDisplayMode(int nSettings)
{
    m_settings.setValue("display",nSettings);
}

int SettingsUtility::readDisplayMode(void)
{
    int display = m_settings.value("display").toInt();
    return display;
}

void SettingsUtility::setRegenMode(int nRegenMode)
{

    int fdPWM2,fdPWM3,fdExport,fdPeriod,fdDutyCycle;

    fdPWM2 = open("sys/class/pwm/pwmchip2",O_RDWR); //File handler

    fdPWM3 = open("sys/class/pwm/pwmchip3",O_RDWR); //File handler

    fdExport = open("/sys/class/pwm/export", O_WRONLY);
    write(fdExport, "0",1);


    fdPeriod = open("sys/class/pwm/pwmchip2/period", O_WRONLY);

    fdDutyCycle = open("sys/class/pwm/pwmchip2/duty_cycle", O_WRONLY);

    //TODO
    //    echo 1000000 > pwm0/period
    //    echo 1000000  > pwm0/duty_cycle
    //    echo 1 > pwm0/enable

    switch(nRegenMode)
    {
        case 0: //25%
        {
            //PWM2 HIGH, PWM3 LOW

            QProcess process;
            process.startDetached("sh",  QStringList() << "-c" << "echo 1000000 > pwm0/period && "
                                                                  "echo 1000000  > pwm0/duty_cycle &&"
                                                                  "echo 1 > pwm0/enable");
            process.close();
            break;
        }
        case 1: //50%
        {
            //PWM2 LOW, PWM3 HIGH
            break;
        }
        case 2: //75%
        {
            //PWM2 HIGH, PWM3 HIGH
            break;
        }
    }

    close(fdPWM2);
    close(fdPWM3);
    close(fdPeriod);
    close(fdDutyCycle);

}

void SettingsUtility::setRideMode(int nRideMode)
{

    int fdPWM0,fdPWM1;

    fdPWM0 = open("sys/class/pwm/pwmchip0",O_RDWR); //File handler

    fdPWM1 = open("sys/class/pwm/pwmchip1",O_RDWR); //File handler

    //TODO
    //    echo 1000000 > pwm0/period
    //    echo 1000000  > pwm0/duty_cycle
    //    echo 1 > pwm0/enable

    switch(nRideMode)
    {
        case 0: //ECO
        {
            //PWM0 HIGH, PWM1 LOW
            break;
        }
        case 1: //STANDARD
        {
            //PWM0 LOW, PWM1 HIGH
            break;
        }
        case 2: //SPORT
        {
            //PWM0 HIGH, PWM1 HIGH
            break;
        }
    }

    close(fdPWM0);
    close(fdPWM1);

}
