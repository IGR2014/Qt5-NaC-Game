#include <QApplication>
#include <QQmlContext>
#include <QQmlApplicationEngine>

// Game engine
#include "nacengine.h"

int main(int argc, char *argv[])
{
	QApplication app(argc, argv);

	QQmlApplicationEngine engine;
	engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

	// Game engine initialization
	NACEngine gameEngine;

	// Get qml engine root context and
	// set our gameEngine as property.
	// Now able to call methods from gameEngine
	engine.rootContext()->setContextProperty("gameEngine", &gameEngine);

	return app.exec();
}
