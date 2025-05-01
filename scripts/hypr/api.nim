import std/[strformat, osproc, os, times, strutils]

type
  Event* = enum
    workspace
    workspacev2
    focusedmon
    focusedmonv2
    activewindow
    activewindowv2
    fullscreen
    monitorremoved
    monitoradded
    monitoraddedv2
    createworkspace
    createworkspacev2
    destroyworkspace
    destroyworkspacev2
    moveworkspace
    moveworkspacev2
    renameworkspace
    activespecial
    activespecialv2
    activelayout
    openwindow
    closewindow
    movewindow
    movewindowv2
    openlayer
    closelayer
    submap
    changefloatingmode
    urgent
    screencast
    windowtitle
    windowtitlev2
    togglegroup
    moveintogroup
    moveoutofgroup
    ignoregrouplock
    lockgroups
    configreloaded
    pin
    minimized

  Workspace* = object
    id*: int
    name*: string

  Monitor* = object
    id*: int
    name*: string
    description*: string
    model*: string
    serial*: string
    width*: int
    height*: int
    refreshRate*: float
    x*: int
    y*: int
    activeWorkspace*: Workspace
    specialWorkspace*: Workspace
    reserved*: seq[int]
    scale*: float
    transform*: int
    focused*: bool
    dpmsStatus*: bool
    vrr*: bool
    solitary*: string
    activelyTearing*: bool
    directScanoutTo*: string
    disabled*: bool
    currentFormat*: string
    mirrorOf*: string
    availableModes*: seq[string]

const skipMonitorAddedEventPath* = getHomeDir() / "scripts/hypr/.skipMonitorAddedEvent"

proc log*(msg: string) =
  echo &"({now().format(\"HH:mm:ss:fff\")}) {msg}"

proc run*(
    cmd: string, input = "", workingDir = ""
): tuple[output: string, exitCode: int] {.discardable.} =
  log &"-> {cmd}"
  execCmdEx(cmd, input = input, workingDir = workingDir)

proc write*(path: string, content: string) =
  log &"{path} ->\n{content.indent(2)}"
  writeFile(path, content)
