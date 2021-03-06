import Felgo 3.0
import QtQuick 2.0
import pages 1.0

Navigation {
    id: navigation

    // first tab
    NavigationItem {
        title: qsTr("Todo List")
        icon: IconType.list

        NavigationStack {
            splitView: tablet // use side-by-side view on tablets
            initialPage: TodoListPage {}
        }
    }
}
