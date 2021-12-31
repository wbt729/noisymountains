import QtQuick 2.15
import Rauschberge 1.0

Item {
    id: root

    property real speed: 0.1
    property real offset: 0
    property real verticalOffset: 0
    property color color: "#3c3c3c"

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

    MountainGenerator {
        id: generator
        width: root.width

        Component.onCompleted: generator.time = root.offset
    }

    Canvas {
        id: canvas
        anchors.fill: parent

        property real vCenter: root.verticalOffset

        onPaint: {
//            console.log("paint")
            var ctx = getContext("2d");
            ctx.reset()



            var mountains = generator.mountains

            for(var m = 0; m < mountains.length; ++m) {
                var mountain = mountains[m]
                ctx.fillStyle = root.color

                // draw outline
                ctx.beginPath()
                ctx.moveTo(mountain.outline[0].x + mountain.x, canvas.height - mountain.outline[0].y)
                for(var i = 1; i < mountain.outline.length; ++i) {
                    var y = canvas.height - mountain.outline[i].y
                    var x = mountain.outline[i].x + mountain.x
                    ctx.lineTo(x, y)
                }
                ctx.closePath()
                ctx.fill()

                // draw ridge
                ctx.fillStyle = "grey"
                ctx.beginPath()
                ctx.moveTo(mountain.outline[0].x + mountain.x, canvas.height - mountain.outline[0].y)
                ctx.lineTo(mountain.outline[1].x + mountain.x, canvas.height - mountain.outline[1].y)
                ctx.lineTo(mountain.outline[2].x + mountain.x, canvas.height - mountain.outline[2].y)
                ctx.lineTo(mountain.ridge[1].x + mountain.x, canvas.height - mountain.ridge[1].y)
                ctx.lineTo(mountain.ridge[2].x + mountain.x, canvas.height - mountain.ridge[2].y)
                ctx.closePath()
                ctx.fill()

                // draw snow
                ctx.fillStyle = "#bbffffff"
                ctx.beginPath()
//                console.log("snow", mountain.snow)
                ctx.moveTo(mountain.snow[0].x + mountain.x, canvas.height - mountain.snow[0].y)
                for(i = 1; i < mountain.snow.length; ++i) {
                    ctx.lineTo(mountain.snow[i].x + mountain.x, canvas.height - mountain.snow[i].y)
                }
                ctx.lineTo(mountain.outline[2].x + mountain.x, canvas.height - mountain.outline[2].y)
                ctx.closePath()
                ctx.fill()
            }
        }
    }
}
