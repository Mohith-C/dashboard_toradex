#Copyright (C) 2019 Claysol Media Labs
#This file is part of Tarform App Cluster.

QT += widgets quick multimedia serialbus
CONFIG += c++11
# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += main.cpp \
    appsleepthread.cpp

HEADERS += \
    appsleepthread.h

RESOURCES += app.qrc \
    $$PWD/../HMI/hmi.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = $$PWD/../HMI/qml
DISTFILES += $$PWD/../HMI/qml/*.qml \
            $$PWD/../HMI/fonts/*.otf

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target


win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../HMI/release/ -lHMI
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../HMI/debug/ -lHMI
else:unix: LIBS += -L$$OUT_PWD/../HMI/ -lHMI

INCLUDEPATH += $$PWD/../HMI
DEPENDPATH += $$PWD/../HMI


INCLUDEPATH += $$PWD/../Communication
DEPENDPATH += $$PWD/../Communication

win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../Communication/release/ -lCommunication
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../Communication/debug/ -lCommunication
else:unix: LIBS += -L$$OUT_PWD/../Communication/ -lCommunication

INCLUDEPATH += $$PWD/../Audio
DEPENDPATH += $$PWD/../Audio


win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../Audio/release/ -lAudio
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../Audio/debug/ -lAudio
else:unix: LIBS += -L$$OUT_PWD/../Audio/ -lAudio


INCLUDEPATH += $$PWD/../ThumbWheel
DEPENDPATH += $$PWD/../ThumbWheel

win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../ThumbWheel/release/ -lThumbWheel
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../ThumbWheel/debug/ -lThumbWheel
else:unix: LIBS += -L$$OUT_PWD/../ThumbWheel/ -lThumbWheel


CONFIG += qtquickcompiler


