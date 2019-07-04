/********************************************************************************
*
* Name:  thumbwheelhandler.h
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
#ifndef THUMBWHEELHANDLER_H
#define THUMBWHEELHANDLER_H

#include <QObject>
#include <QFileSystemWatcher>

class ThumbWheelHandler : public QObject
{
    Q_OBJECT
    public:
        ThumbWheelHandler();
        bool configureGPIO();
        void addWatcher();

    signals:
        void keyPressed(int key);

    private slots:
        void handleLeftKeyPressed();
        void handleRightKeyPressed();
        void handleUpKeyPressed();
        void handleDownKeyPressed();
        void handleReturnKeyPressed();
    private:
        QFileSystemWatcher m_leftKeyWatcher;
        QFileSystemWatcher m_rightKeyWatcher;
        QFileSystemWatcher m_upKeyWatcher;
        QFileSystemWatcher m_downKeyWatcher;
        QFileSystemWatcher m_returnKeyWatcher;

       int m_nLastLeftKeyState = -1;
       int m_nLastRightKeyState = -1;
       int m_nLastUpKeyState = -1;
       int m_nLastDownKeyState = -1;
       int m_nLastReturnKeyState = -1;
};

#endif // THUMBWHEELHANDLER_H
