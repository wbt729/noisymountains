import QtQuick 2.15
import Rauschberge 1.0

Item {
    id: root

    Timer {
        interval: 20
        onTriggered: root.step()
        repeat: true
        running: true
    }

    function step() {
        generator.time += root.speed
        canvas.requestPaint()
    }

    TreeGenerator {
        id: generator
        width: root.width
    }

    Canvas {
        id: canvas
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d");
            ctx.reset()

            var trees = generator.trees
//            console.log(positions)

            for(var p = 0; p < trees.length; ++p) {
//                console.log(p)
//                var centerX = canvas.width / 2
                var centerX = trees[p].x
                var height = trees[p].height
//                var width = Math.random() * (height / 2 - height / 4) + height / 4
                var width = trees[p].width

                ctx.strokeStyle = "black"

//                var nodes = Math.random() * (20 - 10) + 10;
                var nodes = 12
                var outerX = 0
                var outerY = 0
                var innerX = 0
                var topY = 0

                ctx.beginPath();
                topY = canvas.height - height
                ctx.moveTo(centerX, topY)
                for(var i = 0; i < nodes; ++i) {
                    outerX = centerX + (i+1) * width / 2 / nodes
                    outerY = topY + height / nodes * (i+1)
                    ctx.lineTo(outerX, outerY)
                    innerX = centerX + (i+1) * width / 2 / nodes / 3
                    ctx.lineTo(innerX, outerY)
                }
                ctx.lineTo(centerX, canvas.height)
                ctx.fill()

                ctx.beginPath();
                topY = canvas.height - height
                ctx.moveTo(centerX, topY)
                for(i = 0; i < nodes; ++i) {
                    outerX = centerX - (i+1) * width / 2 / nodes
                    outerY = topY + height / nodes * (i+1)
                    ctx.lineTo(outerX, outerY)
                    innerX = centerX - (i+1) * width / 2 / nodes / 3
                    ctx.lineTo(innerX, outerY)
                }
                ctx.lineTo(centerX, canvas.height)
                ctx.closePath()
                ctx.fill()
            }
        }
    }
}
