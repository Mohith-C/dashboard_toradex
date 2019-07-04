/********************************************************************************
*
* Name:  hmisubsystem.h
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
#ifndef HMISUBSYSTEM_H
#define HMISUBSYSTEM_H

#include <QQmlApplicationEngine>
#include "communicationhandler.h"
#include "audiohandler.h"

class HMISubsystem: public QObject
{

    Q_OBJECT
    public:
        HMISubsystem();
        void registerTypes(const char *uri);

    public slots:
        void handleThumbwheel(int key);

    private:
        const char *m_uri = "Tarform.Elements";
        QQmlApplicationEngine m_engine;
        CommunicationHandler m_communicationHandler;
        AudioHandler m_audioHandler;

};

#endif // HMISUBSYSTEM_H
