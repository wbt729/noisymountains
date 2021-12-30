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
            GradientStop { position: 0.6; color: "white" }
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
                ctx.lineTo(x, y);
                ctx.fill();
            }
        }
    }
}
