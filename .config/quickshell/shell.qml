// ~/.config/quickshell/shell.qml
import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Io

PanelWindow {
    id: root

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }
    color: "transparent"

    // Force surface to cover the entire monitor, ignoring Waybar's exclusive zone
    WlrLayershell.layer: WlrLayer.Overlay
    exclusionMode: ExclusionMode.Ignore

    // Pass all mouse events straight to windows below
    mask: Region {}

    WorkspaceGlow {
        id: workspaceGlow
    }

    IpcHandler {
        target: "main"

        function triggerGlow() {
            workspaceGlow.trigger()
        }
    }
}
