#!/usr/bin/env -S nim e --hints:off
import std/[json, sequtils, strformat, os, parseopt]
import ./[api]

const
  monitorsConfigPath = getConfigDir() / "hypr/monitors.conf"

  laptopMonitor = "Chimei Innolux Corporation 0x1521"
  externalMonitor = "YSP MF215BH 0x00001A0A" # The one in my desktop
  tvMonitor = "Samsung Electric Company SAMSUNG 0x01000E00"

  # name/desc, resolution and framerate, position, scale
  laptopDefault = &"desc:{laptopMonitor}, 1920x1080@144.00Hz, auto, 1.2"
  externalDefault = &"desc:{externalMonitor}, 1920x1080@60.00Hz, auto, 1"
  tvDefault = &"desc:{tvMonitor}, 2560x1440@59.95Hz, auto, 1"

var
  # New monitors.conf content if useHyprctl is false
  newConfig =
    """# See https://wiki.hyprland.org/Configuring/Monitors/
# This was generated automatically by """ &
    currentSourcePath() & "\n"
  useHyprctl = false
  enableAll = false # Enable all monitors and ignore configuration rules
  optParser: OptParser

try:
  optParser = initOptParser(longNoVal = @["enableAll"])
  for kind, key, val in getopt():
    case kind
    of cmdArgument:
      discard
    of cmdShortOption:
      discard
    of cmdLongOption: #, cmdShortOption:
      case key
      of "enableAll":
        # useHyprctl = true
        enableAll = true
        log "Detected option --enableAll"
    of cmdEnd:
      discard
except ValueError:
  discard

proc contains[V](arr: openArray[V], values: varargs[V]): bool =
  for v in values:
    if v notin arr:
      return false

  return true

proc getCurrentMonitors(): seq[Monitor] =
  let rawjson = run("hyprctl -j monitors all").output
  let jsonData = rawjson.parseJson()
  jsonData.to(seq[Monitor])

proc getActiveMonitors(): seq[Monitor] =
  let rawjson = run("hyprctl -j monitors").output
  let jsonData = rawjson.parseJson()
  jsonData.to(seq[Monitor])

proc reloadConfig() =
  if not useHyprctl:
    writeFile(monitorsConfigPath, newConfig)
    run("hyprctl reload")

proc monitorKeyword(v: string) =
  if useHyprctl:
    run(&"hyprctl keyword monitor {v}")
  else:
    newConfig.add &"monitor = {v}\n"

proc reloadMonitors*() =
  let currentMonitors = getCurrentMonitors()
  let activeMonitors = getActiveMonitors()
  let currentMonitorsByDesc = currentMonitors.mapIt(it.description)
  log &"Found {currentMonitors.len} monitors ({activeMonitors.len} active): {currentMonitorsByDesc}"

  if enableAll:
    if laptopMonitor in currentMonitorsByDesc:
      monitorKeyword(laptopDefault)
    if externalMonitor in currentMonitorsByDesc:
      monitorKeyword(externalDefault)
    if tvMonitor in currentMonitorsByDesc:
      monitorKeyword(tvDefault)

    writeFile(skipMonitorAddedEventPath, $(currentMonitors.len - activeMonitors.len))
  else:
    case currentMonitors.len
    of 1:
      if laptopMonitor in currentMonitorsByDesc:
        monitorKeyword(laptopDefault)
    of 2:
      if [laptopMonitor, externalMonitor] in currentMonitorsByDesc:
        monitorKeyword(&"desc:{laptopMonitor}, disable")
        monitorKeyword(externalDefault)
      if [laptopMonitor, tvMonitor] in currentMonitorsByDesc:
        monitorKeyword(laptopDefault)
        monitorKeyword(tvDefault)
    else:
      discard

  reloadConfig()

when isMainModule:
  reloadMonitors()
  log &"{monitorsConfigPath} ->\n{newConfig}"
