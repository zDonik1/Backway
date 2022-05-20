#include <QApplication>
#include <FelgoApplication>

#include <QQmlApplicationEngine>
#include <QQmlContext>

// uncomment this line to add the Live Client Module and use live reloading with your custom C++ code
#include <FelgoLiveClient>

#ifdef QT_NO_DEBUG
constexpr auto PUBLISH = true;
#else
constexpr auto PUBLISH = false;
#endif

int main(int argc, char *argv[])
{

  QApplication app(argc, argv);

  FelgoApplication felgo;

  // Use platform-specific fonts instead of Felgo's default font
  felgo.setPreservePlatformFonts(true);

  QQmlApplicationEngine engine;
  felgo.initialize(&engine);

  // Set an optional license key from project file
  // This does not work if using Felgo Live, only for Felgo Cloud Builds and local builds
  felgo.setLicenseKey(PRODUCT_LICENSE_KEY);

  engine.rootContext()->setContextProperty("isPublishStage", PUBLISH);
  felgo.setMainQmlFileName(PUBLISH ? QStringLiteral("qrc:/qml/Main.qml")
                                   : QStringLiteral("qml/Main.qml"));

  engine.load(QUrl(felgo.mainQmlFileName()));

  // to start your project as Live Client, comment (remove) the lines "felgo.setMainQmlFileName ..." & "engine.load ...",
  // and uncomment the line below
  FelgoLiveClient client (&engine);

  return app.exec();
}
