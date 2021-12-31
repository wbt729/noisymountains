import QtQuick 2.15

Item {
    id: root
    property var positions
    property int count: 200

    Component.onCompleted: {
        root.positions = []
        for(var i = 0; i < count; ++i) {
            var point = Qt.point(Math.random(), Math.random())
            positions.push(point)
        }
    }

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.8; color: "white" }
            GradientStop { position: 0.0; color: "darkblue" }
        }
    }

    Canvas {
        id: canvas
        anchors.fill: parent



        onPaint: {
            var ctx = getContext("2d");
            ctx.reset()

            for(var i = 0; i < count; ++i) {
                ctx.beginPath();
//                ctx.fillStyle = "white";
                ctx.fillStyle = "yellow";
                var center = root.positions[i]
                var x = center.x * root.width
                var y = center.y * root.height
                var w = 1
                ctx.moveTo(x, y);
                ctx.arc(x, y, w, Math.PI * 0.5, Math.PI * 2, false);
                ctx.fill();
            }
        }
    }

    Timer {
        id: shootingStarTimer
        onTriggered: anim.start()
    }

    PropertyAnimation {
        id: anim;
        target: shootingStarCanvas
        property: "dist"
        from: 0
        to: 1200;
        duration: 2500
        running: true

        onStopped: {
            shootingStarTimer.interval = 6000 * Math.random()
            shootingStarTimer.start()
        }

        onStarted: {
//            console.log("started")
            shootingStarCanvas.origin = Qt.point(
                    Math.random() * shootingStarCanvas.width,
                        -0.3 * shootingStarCanvas.height
                        )
        }
    }

    Canvas {
        id: shootingStarCanvas
        property real dist: 0
        property point origin: Qt.point(0, 0)
        anchors.fill: parent
        onDistChanged: requestPaint()
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset()

            var grad= ctx.createLinearGradient(origin.x + dist, origin.y + dist, origin.x + 100 + dist, origin.y + 100 + dist);
            grad.addColorStop(0, "#11ffffff");
            grad.addColorStop(1, "white");

            ctx.strokeStyle = grad;

            ctx.beginPath()
            ctx.strokeStyle = grad
            ctx.moveTo(origin.x + dist, origin.y + dist);
            ctx.lineTo(origin.x + 100 + dist, origin.y + 100 + dist)

            ctx.stroke()
        }
    }
}
