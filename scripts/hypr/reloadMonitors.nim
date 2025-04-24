#!/usr/bin/env -S nim e --hints:off
import std/[json, sequtils, strformat, os]
import ./[api]

const
  useHyprctl = false
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

proc contains[V](arr: openArray[V], values: varargs[V]): bool =
  for v in values:
    if v notin arr:
      return false

  return true

proc getCurrentMonitors(): seq[Monitor] =
  let rawjson = run("hyprctl -j monitors all").output
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
  let currentMonitorsByDesc = currentMonitors.mapIt(it.description)
  echo &"Found {currentMonitors.len} monitors: {currentMonitorsByDesc}"
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
