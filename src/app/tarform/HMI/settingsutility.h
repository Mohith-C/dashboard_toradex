/********************************************************************************
*
* Name:  settingsutility.h
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

#ifndef SETTINGSUTILITY_H
#define SETTINGSUTILITY_H


#include <QObject>
#include <QSettings>

class SettingsUtility : public QObject
{
    Q_OBJECT

    public:
        explicit SettingsUtility(QObject *parent = nullptr);

        Q_INVOKABLE void saveRideMode(int nSettings);
        Q_INVOKABLE int readRideMode(void);

        Q_INVOKABLE void saveUnits(int nSettings);
        Q_INVOKABLE int readUnits(void);

        Q_INVOKABLE void saveSoundMode(int nSettings);
        Q_INVOKABLE int readSoundMode(void);

        Q_INVOKABLE void saveRegenMode(int nSettings);
        Q_INVOKABLE int readRegenMode(void);

        Q_INVOKABLE void saveDisplayMode(int nSettings);
        Q_INVOKABLE int readDisplayMode(void);

        Q_INVOKABLE void setRegenMode(int nRegenMode);
        Q_INVOKABLE void setRideMode(int nRideMode);

    private:
            QSettings  m_settings;
};

#endif // SETTINGSUTILITY_H
