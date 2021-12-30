import QtQuick 2.15
import Rauschberge 1.0

Item {
    id: root

    property real speed: 1
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
        root.offset += root.speed
        generator.minimum = root.offset
        generator.maximum = root.offset + root.width
        canvas.requestPaint()
    }

    Generator {
        id: generator
    }

    Canvas {
        id: canvas
        anchors.fill: parent

        property real vCenter: root.verticalOffset

        onWidthChanged: {
            generator.minimum = offset
            generator.maximum = offset + width

            if(!treePositions)
                treePositions = []

            for(var i = generator.minimum; i < generator.maximum; ++i) {
                if(Math.random() < 0.1) {
                    treePositions.push(i)
                }
            }
            console.log("trees", treePositions)
        }

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
            ctx.moveTo(0, org)

            for(var i = 1; i < width; ++i) {
                var y = vCenter + root.amplitude * data[i]
                ctx.lineTo(i, y)
            }

            ctx.lineTo(width, height)
            ctx.lineTo(0, height)
            ctx.lineTo(0, org)
            ctx.closePath()
            ctx.fill()
            ctx.stroke()

            for(var i = 0; i < treePositions.length; ++i) {
                var x = treePositions[i]
                ctx.beginPath()
                console.log(x, offset, x - offset, data[x])
                var y = root.amplitude * data[x]
                ctx.moveTo(x - offset, y)
                ctx.lineTo(x - offset, y + 20)
                ctx.closePath()
                ctx.stroke()
                ctx.fill()
            }
        }
    }
}
