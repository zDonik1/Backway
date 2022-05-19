#include <QApplication>
#include <FelgoApplication>

#include <QQmlApplicationEngine>
#include <QQmlContext>

// uncomment this line to add the Live Client Module and use live reloading with your custom C++ code
#include <FelgoLiveClient>

int main(int argc, char *argv[])
{

  QApplication app(argc, argv);

  FelgoApplication felgo;

  // Use platform-specific fonts instead of Felgo's default font
  felgo.setPreservePlatformFonts(true);

  QQmlApplicationEngine engine;
  felgo.initialize(&engine);

  // Getting view root from either local or remote qml file

  // Set an optional license key from project file
  // This does not work if using Felgo Live, only for Felgo Cloud Builds and local builds
  felgo.setLicenseKey(PRODUCT_LICENSE_KEY);

#ifdef QT_NO_DEBUG
  engine.rootContext()->setContextProperty("isPublishStage", true);
  felgo.setMainQmlFileName(QStringLiteral("qrc:/qml/Main.qml"));
#else
  engine.rootContext()->setContextProperty("isPublishStage", false);
  felgo.setMainQmlFileName(QStringLiteral("qml/Main.qml"));
#endif

  engine.load(QUrl(felgo.mainQmlFileName()));

  // to start your project as Live Client, comment (remove) the lines "felgo.setMainQmlFileName ..." & "engine.load ...",
  // and uncomment the line below
  FelgoLiveClient client (&engine);

  return app.exec();
}
