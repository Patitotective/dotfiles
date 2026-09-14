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

    WlrLayershell.layer: WlrLayer.Overlay
    exclusionMode: ExclusionMode.Ignore
    mask: Region {} 

    WorkspaceGlow {
        id: workspaceGlow
    }

    WindowSpotlight {
        id: windowSpotlight
    }

    IpcHandler {
        target: "main"

        function triggerGlow() {
            workspaceGlow.trigger()
        }

        // Declare explicit types ('real' or 'int') so IPC can serialize arguments
        function triggerSpotlight(xVal: real, yVal: real, wVal: real, hVal: real) {
            windowSpotlight.trigger(xVal, yVal, wVal, hVal)
        }
    }
}
