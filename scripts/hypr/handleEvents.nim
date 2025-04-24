#!/usr/bin/env -S nim e --hints:off
import std/[json, cmdline, strutils, strformat]
import ./[api, reloadMonitors]

# The message from the event is generally the last one
# -> @["e", "--hints:off", "/home/cristobal/scripts/hypr/handleEvents.nims", "activewindowv2>>5d6d5a8841f0"]
let msg = paramStr(paramCount())
if ">>" in msg: # Since messages always contain >>
  let splittedMsg = msg.split(">>")
  let event = parseEnum[Event](splittedMsg[0])
  let data = splittedMsg[1].split(",")

  echo &"Received: {(event: event, data: data)}"

  case event
  # Don't handle this one since monitoraddedv2 is already triggered
  of monitoradded:
    discard
  of monitoraddedv2, monitorremoved:
    reloadMonitors()
  else:
    discard
