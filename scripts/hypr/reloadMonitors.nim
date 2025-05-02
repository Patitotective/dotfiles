#!/usr/bin/env -S nim e --hints:off
import std/[json, sequtils, strformat, os, parseopt, strutils]
import ./[api]

type MonitorConfig = object
  desc*: string
  defaultParams*: string

proc monitorConfig(desc: string, defaultParams: string): MonitorConfig =
  MonitorConfig(desc: desc, defaultParams: defaultParams)

proc default(m: MonitorConfig): string =
  &"desc:{m.desc}, {m.defaultParams}"

proc disabled(m: MonitorConfig): string =
  &"desc:{m.desc}, disable"

const
  monitorsConfigPath = getConfigDir() / "hypr/monitors.conf"
  monitors = (
    laptop: monitorConfig(
      "Chimei Innolux Corporation 0x1521", "1920x1080@144.00Hz, auto, 1.2"
    ),
    external: monitorConfig("YSP MF215BH 0x00001A0A", "1920x1080@60.00Hz, auto, 1"),
      # The one in my desktop
    tv: monitorConfig(
      "Samsung Electric Company SAMSUNG 0x01000E00", "2560x1440@59.95Hz, auto, 1"
    ),
  )
  # name/desc, resolution and framerate, position, scale

var
  # New monitors.conf content if useHyprctl is false
  newConfig = join(
    [
      "# See https://wiki.hyprland.org/Configuring/Monitors/",
      &"# This was generated automatically by {currentSourcePath()}",
      "# Default config for the defined monitors:",
      block:
        var monitorsDefault = ""
        for name, config in monitors.fieldPairs:
          # Remember std/strformat doesn't work with fieldPairs
          monitorsDefault.add "# monitor = " & config.default() & "\n"
        monitorsDefault,
      "monitor = , preferred, auto, 1",
      "\n",
    ],
    "\n",
  )
  enableAll = false # Enable all monitors and ignore configuration rules
  disableEnable = false
    # Disable and enable the active monitors to fix some resolution issues
  optParser: OptParser

try:
  optParser = initOptParser(longNoVal = @["enableAll", "disableEnable"])
  for kind, key, val in getopt():
    case kind
    of cmdArgument:
      discard
    of cmdShortOption:
      discard
    of cmdLongOption: #, cmdShortOption:
      case key
      of "enableAll":
        if disableEnable:
          raise
            newException(ValueError, "Use only one of: --enableAll, --disableEnable")
        enableAll = true
        log "Detected option --enableAll"
      of "disableEnable":
        if enableAll:
          raise
            newException(ValueError, "Use only one of: --enableAll, --disableEnable")
        disableEnable = true
        log "Detected option --disableEnable"
    of cmdEnd:
      discard
except ValueError:
  discard

proc contains[V](arr: openArray[V], values: varargs[V]): bool =
  for v in values:
    if v notin arr:
      return false

  return true

proc getAllMonitors(): seq[Monitor] =
  let rawjson = run("hyprctl -j monitors all").output
  let jsonData = rawjson.parseJson()
  jsonData.to(seq[Monitor])

proc getActiveMonitors(): seq[Monitor] =
  let rawjson = run("hyprctl -j monitors").output
  let jsonData = rawjson.parseJson()
  jsonData.to(seq[Monitor])

proc reloadConfig() =
  write(monitorsConfigPath, newConfig)
  run("hyprctl reload")

proc monitorKeyword(v: string, useHyprctl = false) =
  if useHyprctl:
    run(&"hyprctl keyword monitor {v}")
  else:
    newConfig.add &"monitor = {v}\n"

proc reloadMonitors*(enableAll = false) =
  let allMonitors = getAllMonitors()
  let activeMonitors = getActiveMonitors()
  let allMonitorsByDesc = allMonitors.mapIt(it.description)
  log &"Found {allMonitors.len} monitors ({activeMonitors.len} active): {allMonitorsByDesc}"

  if enableAll:
    for name, config in monitors.fieldPairs:
      if config.desc in allMonitorsByDesc:
        monitorKeyword(config.default())

    writeFile(skipMonitorAddedEventPath, $(allMonitors.len - activeMonitors.len))
  else:
    case allMonitors.len
    of 1:
      if monitors.laptop.desc in allMonitorsByDesc:
        monitorKeyword(monitors.laptop.default())
    of 2:
      if [monitors.laptop.desc, monitors.external.desc] in allMonitorsByDesc:
        monitorKeyword(monitors.laptop.disabled())
        monitorKeyword(monitors.external.default())
      if [monitors.laptop.desc, monitors.tv.desc] in allMonitorsByDesc:
        monitorKeyword(monitors.laptop.default())
        monitorKeyword(monitors.tv.default())
    else:
      discard

  reloadConfig()

proc disableEnableMonitors*() =
  return
  let activeMonitors = getActiveMonitors()
  let activeMonitorsByDesc = activeMonitors.mapIt(it.description)
  monitorKeyword(monitors.laptop.default(), useHyprctl = true)
  monitorKeyword(monitors.external.disabled(), useHyprctl = true)
  monitorKeyword(monitors.external.default(), useHyprctl = true)
  monitorKeyword(monitors.laptop.disabled(), useHyprctl = true)
  # for name, config in monitors.fieldPairs:
  #   if config.desc in activeMonitorsByDesc:
  #     monitorKeyword(config.disabled(), useHyprctl = true)
  #     monitorKeyword(config.default(), useHyprctl = true)
  #     monitorKeyword(config.default(), useHyprctl = true)

when isMainModule:
  if disableEnable:
    disableEnableMonitors()
  elif enableAll:
    reloadMonitors(enableAll = true)
  else:
    reloadMonitors()
