import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Sky {
        anchors.fill: parent
    }

    Layer {
        anchors.fill: parent
        verticalOffset: height / 2
        amplitude: 50
//        color: "#565656"
        color: "darkgreen"
        speed: 2
    }

    Layer {
        anchors.fill: parent
        verticalOffset: 2/3 * height
        amplitude: 50
        offset: -1000
//        color: "#3c3c3c"
        color: Qt.darker("darkgreen")
        speed: 4
    }

    Layer {
        anchors.fill: parent
        verticalOffset: 4/5 * height
        amplitude: 60
        offset: 9000
//        color: "#1f1f1f"
        color: Qt.darker(Qt.darker("darkgreen"))
        speed: 6
    }

//    Slider {
//        id: slide
//        anchors { left: parent.left; right: parent.right; bottom: parent.bottom }
//        from: 0
//        to: 10
//    }
}
