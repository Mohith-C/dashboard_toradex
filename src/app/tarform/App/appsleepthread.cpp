#include "appsleepthread.h"
#include <QDebug>
#include <QProcess>
#include <fcntl.h>
#include <unistd.h>
#include <QTimer>


AppSleepThread::AppSleepThread()
{
    connect(this, &AppSleepThread::sleepModeActivated, this, &AppSleepThread::handleSleepMode);
    connect(this, &AppSleepThread::wakeupModeActivated, this, &AppSleepThread::handleWakeupMode);
    connect(this, &AppSleepThread::finished, this, &QObject::deleteLater);
    connect(&m_movie, &QMovie::finished, this, &AppSleepThread::hideWakeupAnimation);


    //TODO: Check sleep/wakeup pin and replace accordingly.
    int result = open("/sys/class/gpio/export", O_WRONLY);
    write(result, "38",2);
    close(result);

    result = open("/sys/class/gpio/gpio38/direction", O_WRONLY);
    write(result, "in",2);
    close(result);

}


void AppSleepThread:: run()
{
    char cDirection;
    int nRet =-1;
    int nNewState = -1;
    int nLastState = -1;

    while(1)
    {
        // Infiniteloop

        nRet = open("/sys/class/gpio/gpio38/value", O_RDONLY);
        read(nRet, &cDirection, 1); // read GPIO value
        nNewState = atoi(&cDirection);
        close(nRet); //close value file

        if (nLastState != nNewState)
        {
            if(0 == nNewState)
            {
                emit sleepModeActivated();
            }
            else if(1 == nNewState)
            {
                emit wakeupModeActivated();
            }
            else
            {
                qDebug() << "Invalid value received!";
            }
        }
        nLastState = nNewState;
        sleep(1);
    }
}


void AppSleepThread::handleSleepMode()
{
    //qDebug() << Q_FUNC_INFO;

    m_movie.setFileName("/etc/tarform/tarform.gif");
    m_movie.setBackgroundColor(Qt::black);
    m_wakeUpScreen.setMovie(&m_movie);
    m_wakeUpScreen.showMaximized();
    m_movie.start();
    m_movie.setPaused(true);

    QProcess process;
    process.startDetached("sh",  QStringList() << "-c" << "echo mem>/sys/power/state");
    process.close();
    qDebug() << "Tarform app going to sleep!";
}


void AppSleepThread::handleWakeupMode()
{
	QTimer::singleShot(6000, this, SLOT(hideWakeupAnimation()));
    qDebug() << "Tarform app resumed!";
    
    m_movie.setPaused(false);
	m_wakeUpScreen.update();
    //m_movie.start();
	

    //Display boot animation
    //QProcess::startDetached("gst-play-1.0 /etc/tarform/tarform.mp4");
    //Ignition Sound
    //QProcess::startDetached("aplay -c 1 -t wav -r 44100 -f S16_LE /etc/tarform/ignition.wav");

  
}

void AppSleepThread::hideWakeupAnimation()
{
	m_movie.stop();
    m_wakeUpScreen.hide();
QProcess::startDetached("aplay -c 1 -t wav -r 44100 -f S16_LE /etc/tarform/ignition.wav");
}
