#include <QtQml>

#include "hmisubsystem.h"
#include "powerring.h"
#include "settingsutility.h"

HMISubsystem::HMISubsystem()
{
    registerTypes(m_uri);
    m_engine.rootContext()->setContextProperty("m_communicationHandler", &m_communicationHandler);
    m_engine.rootContext()->setContextProperty("m_audioHandler", &m_audioHandler);
    m_engine.load(QUrl(QStringLiteral("qrc:/qml/qml/main.qml")));

}

void HMISubsystem::registerTypes(const char *uri)
{
    qmlRegisterType(QUrl("qrc:/qml/qml/HomeScreen.qml"), uri, 1, 0, "HomeScreen");
    qmlRegisterType(QUrl("qrc:/qml/qml/SettingsScreen.qml"), uri, 1, 0, "SettingsScreen");
    qmlRegisterType(QUrl("qrc:/qml/qml/ChargingScreen.qml"), uri, 1, 0, "ChargingScreen");
    qmlRegisterType(QUrl("qrc:/qml/qml/BatteryStatistics.qml"), uri, 1, 0, "BatteryStatistics");
    qmlRegisterType(QUrl("qrc:/qml/qml/BluetoothOptions.qml"), uri, 1, 0, "BluetoothOptions");
    qmlRegisterType(QUrl("qrc:/qml/qml/ChargeOptions.qml"), uri, 1, 0, "ChargeOptions");
    qmlRegisterType(QUrl("qrc:/qml/qml/DisplayOptions.qml"), uri, 1, 0, "DisplayOptions");
    qmlRegisterType(QUrl("qrc:/qml/qml/RideOptions.qml"), uri, 1, 0, "RideOptions");
    qmlRegisterType(QUrl("qrc:/qml/qml/RegenOptions.qml"), uri, 1, 0, "RegenOptions");
    qmlRegisterType(QUrl("qrc:/qml/qml/SoundOptions.qml"), uri, 1, 0, "SoundOptions");

    qmlRegisterType<PowerRing>("Tarform.Elements", 1, 0, "PowerRing");
    qmlRegisterType<SettingsUtility>("Tarform.Elements", 1, 0, "SettingsUtility");

}

void HMISubsystem::handleThumbwheel(int key)
{
    QCoreApplication::postEvent(m_engine.rootObjects().at(0), new QKeyEvent(QEvent::KeyPress, (Qt::Key)key, Qt::NoModifier));
}
