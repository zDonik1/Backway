import Felgo 3.0
import QtQuick 2.0
import QtQuick.Layouts 1.15

import "model"
import "logic"


App {
    function checkServerAccess() {
        if(isOnline) {
            logic.clearCache()

            if (isPublishStage) {
                HttpRequest
                .head(viewRoot)
                .end((err, res) => {
                         if (!res.ok) {
                             stack.currentIndex = 1
                         }
                     });
            }
        }
    }

    // app initialization
    Component.onCompleted: {
        checkServerAccess()

        // fetch todo list data
        logic.fetchTodos()
        logic.fetchDraftTodos()
    }

    // business logic
    Logic {
        id: logic
    }

    // model
    DataModel {
        id: dataModel
        dispatcher: logic // data model handles actions sent by logic

        // global error handling
        onFetchTodosFailed: nativeUtils.displayMessageBox("Unable to load todos", error, 1)
        onFetchTodoDetailsFailed: nativeUtils.displayMessageBox("Unable to load todo "+id, error, 1)
        onStoreTodoFailed: nativeUtils.displayMessageBox("Failed to store "+viewHelper.formatTitle(todo))
    }

    // helper functions for view
    ViewHelper {
        id: viewHelper
    }

    // view
    StackLayout {
        id: stack
        anchors.fill: parent
        currentIndex: !isOnline ? 1 : viewLoader.status === Loader.Ready ? 2 : 0

        Page {
            AppActivityIndicator {
                id: networkIndicator
                anchors.centerIn: parent
                iconSize: dp(50)
                hidesWhenStopped: true
                animating: viewLoader.status === Loader.Loading
            }
        }

        Page {
            AppText {
                anchors.centerIn: parent
                text: qsTr("Failed to connect to server.\nPlease check your internet connetion")
                horizontalAlignment: Text.AlignHCenter
            }
        }

        Loader {
            id: viewLoader
            asynchronous: isPublishStage
            source: viewRoot + "/View.qml"
        }
    }
}
