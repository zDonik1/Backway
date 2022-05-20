# allows to add DEPLOYMENTFOLDERS and links to the Felgo library and QtCreator auto-completion
CONFIG += felgo

# uncomment this line to add the Live Client Module and use live reloading with your custom C++ code
# for the remaining steps to build a custom Live Code Reload app see here: https://felgo.com/custom-code-reload-app/
CONFIG(debug, debug|release):CONFIG += felgo-live

# Project identifier and version
# More information: https://felgo.com/doc/felgo-publishing/#project-configuration
PRODUCT_IDENTIFIER = com.zdonik.Backway
PRODUCT_VERSION_NAME = 1.0.0
PRODUCT_VERSION_CODE = 1

CONFIG(debug, debug|release) {
    qmlFolder.source = qml
    DEPLOYMENTFOLDERS += qmlFolder # comment for publishing

    assetsFolder.source = assets
    DEPLOYMENTFOLDERS += assetsFolder
} else {
    defined(PRODUCT_LICENSE_KEY, var): \
        DEFINES += "PRODUCT_LICENSE_KEY=\"$$PRODUCT_LICENSE_KEY\""
    RESOURCES += resources.qrc # uncomment for publishing
}

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp

android {
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
    OTHER_FILES += \
        android/AndroidManifest.xml \
        android/build.gradle
}

ios {
    QMAKE_INFO_PLIST = ios/Project-Info.plist
    OTHER_FILES += $$QMAKE_INFO_PLIST
}

# set application icons for win and macx
win32 {
    RC_FILE += win/app_icon.rc
}
macx {
    ICON = macx/app_icon.icns
}
