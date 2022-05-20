# Backway

Demo application for showing how to use back-end way development in Qt/QML application. The technique allows for over-the-air updates for the UI (and business logic), which means that it will be downloaded from a server when the application is loaded and updates do not require an update on binary application package.

In this application only the UI is downloaded over the internet. The QML files for the UI are hosted in a server under http://zdonik.mukhtarov.net:8000/.

Selecting the Debug configuration in QtCreator will allow to build a Felgo Live Client application for easy development of UI, while Release configuration let's final application to be built.

The felgo license key can be inserted as a QMake variable in build steps of QtCreator.
