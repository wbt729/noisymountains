import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Window {
    width: 800
    height: 480
    visible: true
    title: qsTr("Hello World")

    Sky {
        anchors.fill: parent
    }

//    Mountains {
//        id: backgroundMountains
//        anchors.fill: parent
//        visible: false
//    }

//    DropShadow {
//        anchors.fill: backgroundMountains
//        horizontalOffset: 3
//        verticalOffset: 3
//        radius: 8.0
//        samples: 17
//        color: "#80000000"
//        source: backgroundMountains
//    }

    Mountains {
        id: mountains
        anchors.fill: parent
        visible: false
    }

    DropShadow {
        anchors.fill: mountains
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 17
        color: "#80000000"
        source: mountains
    }

    Layer {
        id: backgroundHills
        visible: false
        anchors.fill: parent
        verticalOffset: 3/5 * height
        amplitude: 40
        offset: -1000
//        color: "#3c3c3c"
        color: Qt.darker("darkgreen")
        speed: 2
    }

    DropShadow {
        anchors.fill: backgroundHills
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 17
        color: "#80000000"
        source: backgroundHills
    }

    Layer {
        id: foregroundHills
        anchors.fill: parent
        verticalOffset: 4/6 * height
        amplitude: 30
        offset: 9000
//        color: "#1f1f1f"
        color: Qt.darker(Qt.darker("darkgreen"))
        speed: 4
        visible: false
    }

    DropShadow {
        anchors.fill: foregroundHills
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 17
        color: "#80000000"
        source: foregroundHills
    }

    Trees {
        id: trees
        anchors.fill: parent
        visible: false
    }

    DropShadow {
        anchors.fill: trees
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 17
        color: "#80000000"
        source: trees
    }

//    Slider {
//        id: slide
//        anchors { left: parent.left; right: parent.right; bottom: parent.bottom }
//        from: 0
//        to: 10
//    }
}
