/********************************************************************************
*
* Name:  audiohandler.h
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
#ifndef AUDIOHANDLER_H
#define AUDIOHANDLER_H

#include <QObject>

class QMediaPlayer;
class QMediaPlaylist;

class  AudioHandler: public QObject
{
    Q_OBJECT

    public:
        AudioHandler();
        ~AudioHandler();
        bool initialize();

    public slots:
        Q_INVOKABLE void handleSpeedChanged(int speed);
        Q_INVOKABLE void updateSoundProfile();
        void handlePositionChanged(qint64 pos);

    private:
        bool loadSoundFile(const QString &fileName);
        QString readSoundSettings();

        QString m_strSoundPath = "";
        int m_nPrevSpeed = 0;
        QMediaPlayer* m_pPlayer = nullptr;
        QMediaPlaylist* m_pPlaylist = nullptr;
};

#endif // AUDIOHANDLER_H
