#include "thumbwheelhandler.h"

//#include <QDebug>
#include <QProcess>
#include <fcntl.h>
#include <unistd.h>

ThumbWheelHandler::ThumbWheelHandler()
{
    configureGPIO();
    addWatcher();
   // qDebug() << "ThumbWheelHandler Loaded";
}

bool ThumbWheelHandler::configureGPIO()
{
    int result = 0;

    // export GPIO4(Left key)
    result = open("/sys/class/gpio/export", O_WRONLY);
    write(result, "39",2);
    close(result);

    // configure as input GPIO4(Left key)
    result = open("/sys/class/gpio/gpio39/direction", O_WRONLY);
    write(result, "in",2);
    close(result);


    // export GPIO5(Centre key)
    result = open("/sys/class/gpio/export", O_WRONLY);
    write(result, "170",3);
    close(result);

    // configure as input GPIO4(Center key)
    result = open("/sys/class/gpio/gpio170/direction", O_WRONLY);
    write(result, "in",2);
    close(result);


    // export GPIO6(up key)
    result = open("/sys/class/gpio/export", O_WRONLY);
    write(result, "169",3);
    close(result);

    // configure as input GPIO6(up key)
    result = open("/sys/class/gpio/gpio169/direction", O_WRONLY);
    write(result, "in",2);
    close(result);

    // export GPIO6(right key)
    result = open("/sys/class/gpio/export", O_WRONLY);
    write(result, "2",1);
    close(result);

    // configure as input GPIO5(right key)
    result = open("/sys/class/gpio/gpio2/direction", O_WRONLY);
    write(result, "in",2);
    close(result);

    // export GPIO6(down key)
    result = open("/sys/class/gpio/export", O_WRONLY);
    write(result, "6",1);
    close(result);

    // configure as input GPIO6(down key)
    result = open("/sys/class/gpio/gpio6/direction", O_WRONLY);
    write(result, "in",2);
    close(result);

    return true;
}

 void ThumbWheelHandler::addWatcher()
 {
     m_leftKeyWatcher.addPath("/sys/class/gpio/gpio39/value");
     QProcess leftKeyProcess;
     leftKeyProcess.startDetached("sh",  QStringList() << "-c" << "echo 'both' > /sys/class/gpio/gpio39/edge");
     leftKeyProcess.close();
     connect(&m_leftKeyWatcher, &QFileSystemWatcher::fileChanged, this, &ThumbWheelHandler::handleLeftKeyPressed);

     m_rightKeyWatcher.addPath("/sys/class/gpio/gpio2/value");
     QProcess rightKeyProcess;
     rightKeyProcess.startDetached("sh",  QStringList() << "-c" << "echo 'both' > /sys/class/gpio/gpio2/edge");
     rightKeyProcess.close();
     connect(&m_rightKeyWatcher, &QFileSystemWatcher::fileChanged, this, &ThumbWheelHandler::handleRightKeyPressed);

     m_upKeyWatcher.addPath("/sys/class/gpio/gpio169/value");
     QProcess upKeyProcess;
     upKeyProcess.startDetached("sh",  QStringList() << "-c" << "echo 'both' > /sys/class/gpio/gpio169/edge");
     upKeyProcess.close();
     connect(&m_upKeyWatcher, &QFileSystemWatcher::fileChanged, this, &ThumbWheelHandler::handleUpKeyPressed);

     m_downKeyWatcher.addPath("/sys/class/gpio/gpio6/value");
     QProcess downKeyProcess;
     upKeyProcess.startDetached("sh",  QStringList() << "-c" << "echo 'both' > /sys/class/gpio/gpio6/edge");
     upKeyProcess.close();
     connect(&m_downKeyWatcher, &QFileSystemWatcher::fileChanged, this, &ThumbWheelHandler::handleDownKeyPressed);

     m_returnKeyWatcher.addPath("/sys/class/gpio/gpio170/value");
     QProcess returnKeyProcess;
     returnKeyProcess.startDetached("sh",  QStringList() << "-c" << "echo 'both' > /sys/class/gpio/gpio170/edge");
     returnKeyProcess.close();
     connect(&m_returnKeyWatcher, &QFileSystemWatcher::fileChanged, this, &ThumbWheelHandler::handleReturnKeyPressed);
 }

 void ThumbWheelHandler::handleLeftKeyPressed()
 {
     int result = 0;
     int nKeyState = -1;
     char cDirection;
     result = open("/sys/class/gpio/gpio39/value", O_RDONLY);
     read(result, &cDirection, 1); // read GPIO value
     //qDebug()<< "Done reading left key: " << atoi(&cDirection);
     nKeyState = atoi(&cDirection);
     close(result); //close value file

     if((m_nLastLeftKeyState != nKeyState) && (0 == nKeyState))
     {
         // qDebug() << "Left Key Pressed";
         emit keyPressed(Qt::Key_Left);
     }
     m_nLastLeftKeyState = nKeyState;

 }

 void ThumbWheelHandler::handleRightKeyPressed()
 {

   int result = 0;
   int nKeyState = -1;
   char cDirection;
   result = open("/sys/class/gpio/gpio2/value", O_RDONLY);
   read(result, &cDirection, 1); // read GPIO value
   //qDebug() << "Done reading right key: " << atoi(&cDirection);
   close(result); //close value file
   nKeyState = atoi(&cDirection);
   if((m_nLastRightKeyState != nKeyState) && (0 == nKeyState))
   {
      // qDebug() << "Right Key Pressed";
      emit keyPressed(Qt::Key_Right);
   }
   m_nLastRightKeyState = nKeyState;
 }

 void ThumbWheelHandler::handleUpKeyPressed()
 {

     int result = 0;
     int nKeyState = -1;
     char cDirection;
     result = open("/sys/class/gpio/gpio169/value", O_RDONLY);
     read(result, &cDirection, 1); // read GPIO value
     //qDebug() << "Done reading up key: " << atoi(&cDirection);
     close(result); //close value file
     nKeyState = atoi(&cDirection);
     if((m_nLastUpKeyState != nKeyState) && (0 == nKeyState))
     {
        // qDebug() << "Up Key Pressed";
         emit keyPressed(Qt::Key_Up);
     }
     m_nLastUpKeyState = nKeyState;
 }

 void ThumbWheelHandler::handleDownKeyPressed()
 {
    int result = 0;
    int nKeyState = -1;
    char cDirection;
    result = open("/sys/class/gpio/gpio6/value", O_RDONLY);
    read(result, &cDirection, 1); // read GPIO value
    //qDebug() << "Done reading down key: " << atoi(&cDirection);
    close(result); //close value file
    nKeyState = atoi(&cDirection);
    if((m_nLastDownKeyState != nKeyState) && (0 == nKeyState))
    {
       // qDebug() << "Down Key Pressed";
        emit keyPressed(Qt::Key_Down);
    }
    m_nLastDownKeyState = nKeyState;
 }

 void ThumbWheelHandler::handleReturnKeyPressed()
 {
     int result = 0;
     int nKeyState = -1;
     char cDirection;
     result = open("/sys/class/gpio/gpio170/value", O_RDONLY);
     read(result, &cDirection, 1); // read GPIO value
     //qDebug()<< "Done reading Enter/Return key: " << atoi(&cDirection);
     close(result); //close value file
     nKeyState = atoi(&cDirection);
     if((m_nLastReturnKeyState != nKeyState) && (0 == nKeyState))
     {
        // qDebug() << "Enter/Return Key Pressed";
         emit keyPressed(Qt::Key_Return);
     }
     m_nLastReturnKeyState = nKeyState;
 }
