#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "generator.h"
#include "treegenerator.h"


int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    qmlRegisterType<Generator>("Rauschberge", 1, 0, "Generator");
    qmlRegisterType<TreeGenerator>("Rauschberge", 1, 0, "TreeGenerator");

    Generator generator;

    QQmlApplicationEngine engine;
//    engine.rootContext()->setContextProperty("generator", &generator);
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
