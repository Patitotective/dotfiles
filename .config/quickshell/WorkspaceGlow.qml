// ~/.config/quickshell/WorkspaceGlow.qml
import QtQuick
import Qt5Compat.GraphicalEffects

Item {
    id: glowRoot
    anchors.fill: parent

    readonly property color accentCore: "#78a9ff"    // color13
    readonly property color accentGlow: "#be95ff"    // color14

    // Horizon Glow Bar
    Rectangle {
        id: horizonBar
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        
        height: 1
        radius: 1.5
        color: glowRoot.accentCore
        opacity: 0.0
        width: parent.width * 0.15

        // Soft, ambient neon bloom beneath the bar
        RectangularGlow {
            anchors.fill: parent
            glowRadius: 4
            spread: 0.15
            color: glowRoot.accentGlow
            cornerRadius: parent.radius
        }
    }

    // Apple-style fluid animation sequence
    ParallelAnimation {
        id: applePulse

        // 1. Horizontal expansion (breathes outward smoothly)
        NumberAnimation {
            target: horizonBar
            property: "width"
            from: glowRoot.width * 0.01
            to: glowRoot.width
            duration: 580
            easing.type: Easing.OutQuint // Silky smooth deceleration
        }

        // 2. Continuous, non-sudden Opacity Curve
        SequentialAnimation {
            // Smooth, subtle fade-in
            NumberAnimation {
                target: horizonBar
                property: "opacity"
                from: 0.0
                to: 0.85
                duration: 140
                easing.type: Easing.OutCubic
            }
            // Gentle, elegant fade-out
            NumberAnimation {
                target: horizonBar
                property: "opacity"
                from: 0.85
                to: 0.0
                duration: 340
                easing.type: Easing.InOutQuad
            }
        }
    }

    function trigger() {
        applePulse.restart()
    }
}
