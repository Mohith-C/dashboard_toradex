/********************************************************************************
*
* Name:  appsleepthread.h
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
* Date      11 June 2019
********************************************************************************/
#ifndef APPSLEEPTHREAD_H
#define APPSLEEPTHREAD_H

#include <QThread>
#include <QLabel>
#include <QMovie>

class AppSleepThread: public QThread
{
    Q_OBJECT
    public:
        AppSleepThread();
        void run() override;

    private slots:
        void handleSleepMode();
        void handleWakeupMode();
        void hideWakeupAnimation();

    signals:
        void sleepModeActivated();
        void wakeupModeActivated();
    private:
        QLabel m_wakeUpScreen;
        QMovie m_movie;
};

#endif // APPSLEEPTHREAD_H
