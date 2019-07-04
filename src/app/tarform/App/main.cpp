/********************************************************************************
*
* Name: main.cpp
*
* Copyright (c) 2019 Claysol Media Labs.
*
* This file is part of Tarform App Cluster.
*
* Description:
*       main program
*
*
* Author	Nibedit Dey
* Date      11 Mar 2019
********************************************************************************/


#include <QApplication>
#include <QProcess>
#include <QTime>
#include <QDebug>
#include <QObject>
#include "hmisubsystem.h"
#include "thumbwheelhandler.h"
#include "appsleepthread.h"
#include <csignal>

using namespace std;

struct CleanExit
{
    CleanExit()
    {
        signal(SIGINT, &CleanExit::shutdownApp);
        signal(SIGTERM, &CleanExit::shutdownApp);
        signal(SIGABRT, &CleanExit::shutdownApp);
    }

    static void shutdownApp(int)
    {
        QApplication::exit(0);
    }
};


int main(int argc, char *argv[])
{
    CleanExit m_cleanExit;

    qDebug()<<"Kernel Loaded : " << QDateTime::currentDateTime();
    QTime m_time;
    m_time.start();

    qDebug()<<"Tarform Application started : " << m_time.elapsed();

    if (qEnvironmentVariableIsEmpty("QTGLESSTREAM_DISPLAY"))
       {
           qputenv("QT_QPA_EGLFS_PHYSICAL_WIDTH", QByteArray("800"));
           qputenv("QT_QPA_EGLFS_PHYSICAL_HEIGHT", QByteArray("800"));
           QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
       }

    QApplication app(argc, argv);

    QApplication::setOrganizationName("Tarform Motors");
    QApplication::setOrganizationDomain("https://tarform.com");
    QApplication::setApplicationName("Tarform");

    //Load Components
    qDebug()<<"Loading HMI : " << m_time.elapsed();
    HMISubsystem m_hmisubsystem;
    qDebug()<<"App loaded : " << m_time.elapsed();

    //Ignition Sound
    QProcess::startDetached("aplay -c 1 -t wav -r 44100 -f S16_LE /etc/tarform/ignition.wav");
    ThumbWheelHandler m_thumbWheelHandler;
    //!End of Component Loading

    QObject::connect(&m_thumbWheelHandler,SIGNAL(keyPressed(int)),&m_hmisubsystem,SLOT(handleThumbwheel(int)));

    //Start the Sleep-Wakeup Thread
    AppSleepThread *m_pSleepThread = new AppSleepThread();
    if(m_pSleepThread)
        m_pSleepThread->start();
    //!

    return app.exec();
}

