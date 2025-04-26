#!/usr/bin/env -S nim e --hints:off
import std/[json, cmdline, strutils, strformat, os]
import ./[api, reloadMonitors]

# The message from the event is generally the last one
# -> @["e", "--hints:off", "/home/cristobal/scripts/hypr/handleEvents.nims", "activewindowv2>>5d6d5a8841f0"]
let msg = paramStr(paramCount())
if ">>" in msg: # Since messages always contain >>
  let splittedMsg = msg.split(">>")
  let event = parseEnum[Event](splittedMsg[0])
  let data = splittedMsg[1].split(",")

  log &"Received: {(event: event, data: data)}"

  case event
  # Don't handle this one since monitoraddedv2 is already triggered
  of monitoradded:
    discard
  of monitorremoved:
    reloadMonitors()
  of monitoraddedv2:
    var skipMonitorAddedEvent = false

    if fileExists(skipMonitorAddedEventPath):
      var monitorsToSkip = 0
      try:
        let fileContent = readFile(skipMonitorAddedEventPath)
        monitorsToSkip = fileContent.parseInt()
      except ValueError:
        removeFile(skipMonitorAddedEventPath)
        log "&Invalid file {skipMonitorAddedEventPath}, removing it"

      if monitorsToSkip > 0:
        skipMonitorAddedEvent = true
        writeFile(skipMonitorAddedEventPath, $(monitorsToSkip - 1))
        log "Skipping monitoraddedv2 event"
      elif monitorsToSkip <= 0 and fileExists(skipMonitorAddedEventPath):
        removeFile(skipMonitorAddedEventPath)

    if not skipMonitorAddedEvent:
      reloadMonitors()
  else:
    discard
