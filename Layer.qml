import QtQuick 2.15
import Rauschberge 1.0

Item {
    id: root

    property real speed: 0.1
    property real offset: 0
    property real verticalOffset: 0
    property real amplitude: 10
    property color color: "black"

    property var treePositions

    Timer {
        interval: 50
        onTriggered: root.step()
        repeat: true
        running: true
    }

    function step() {
        generator.time += root.speed
        canvas.requestPaint()
    }

    Generator {
        id: generator
        width: root.width

        Component.onCompleted: generator.time = root.offset
    }

    Canvas {
        id: canvas
        anchors.fill: parent

        property real vCenter: root.verticalOffset

        onPaint: {
            var ctx = getContext("2d");
            ctx.reset()

            var data = generator.getData()
            var org = vCenter + root.amplitude * data[0]
            ctx.lineWidth = 1
//            ctx.strokeStyle = Qt.rgba(0, 0, 0, 1)
            ctx.strokeStyle = root.color
//            ctx.fillStyle = Qt.rgba(0, 0, 0, 1)
            ctx.fillStyle = root.color
            ctx.beginPath()
            ctx.moveTo(data[0].x, org)

            for(var i = 1; i < width; ++i) {
                var x = data[i].x
                var y = vCenter + root.amplitude * data[i].y
                ctx.lineTo(i, y)
            }

            ctx.lineTo(width, height)
            ctx.lineTo(0, height)
            ctx.lineTo(0, org)
            ctx.closePath()
            ctx.fill()
            ctx.stroke()
        }
    }
}
