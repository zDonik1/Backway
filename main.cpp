#include <QApplication>
#include <FelgoApplication>

#include <QQmlApplicationEngine>
#include <QQmlContext>

#ifdef QT_NO_DEBUG
constexpr auto PUBLISH = true;
#else
#include <FelgoLiveClient>
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
  engine.addImportPath("qml/views");

#ifdef QT_NO_DEBUG
  felgo.setMainQmlFileName(QStringLiteral("qrc:/qml/Main.qml"));
  engine.load(QUrl(felgo.mainQmlFileName()));
#else
  FelgoLiveClient client(&engine);
#endif

  return app.exec();
}
