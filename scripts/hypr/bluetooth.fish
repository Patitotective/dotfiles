#!/bin/fish
function name-to-icon
    # Based from the icons in https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/dbus-common.c
    # blob = 5e2c83d52628b077116e366ba43a19b4edfc5266
    switch $argv[1]
        case computer
            echo 󰇅
        case phone
            echo 󰄜
        case modem
            echo 󱂇
        case network-wireless
            echo 󰖩
        case audio-headset
            echo 󰋎
        case audio-headphones
            echo 
        case camera-video # VCR, Video Camera, Camcorder # VCR, Video Camera, Camcorder # VCR, Video Camera, Camcorder
            echo 
        case audio-card # Other audio device
            echo 󰤽
        case input-gaming
            echo 󰊗
        case input-keyboard
            echo 󰌌
        case input-tablet
            echo 󰓶
        case input-mouse
            echo 󰍽
        case printer
            echo 󰐪
        case camera-photo
            echo 󰄀
        case video-display multimedia-player
            echo 󰻏
        case scanner
            echo 󰚫
        case unknown '*'
            echo 󰾰
    end
end

function main
    set -l on (bluetoothctl show | rg '\tPowered: (yes|no)' -r '$1')
    if test $on = yes
        set on
    else
        set -e on
    end

    if set -q on
        set -l connectedDevicesRaw (bluetoothctl devices Connected)
        set -l pairedDevicesRaw (bluetoothctl devices Paired)
        set -l devicesRaw (bluetoothctl devices)

        # TODO: create a connectedDevicesIcons, pairedDevicesIcons, devicesIcons
        # that use 'bluetoothctl info DEVICE_ID' and name-to-icon
        for d in $connectedDevicesRaw
            set -a connectedDevices (echo $d | rg 'Device .+? (.+)' -r '$1')
            set -a connectedDevicesIds (echo $d | rg 'Device (.+?) .+' -r '$1')
        end

        for d in $pairedDevicesRaw
            set -l id (echo $d | rg 'Device (.+?) .+' -r '$1')
            if not contains $id $connectedDevicesIds
                set -a pairedDevices (echo $d | rg 'Device .+? (.+)' -r '$1')
                set -a pairedDevicesIds $id
            end
        end

        for d in $devicesRaw
            set -l id (echo $d | rg 'Device (.+?) .+' -r '$1')
            if not contains $id $pairedDevicesIds; and not contains $id $connectedDevicesIds
                set -a devices (echo $d | rg 'Device .+? (.+)' -r '$1')
                set -a devicesIds $id
            end
        end

        set -a opts "󰂲  Turn off bluetooth"
        set -a opts "󰑓  Scan for devices"
    else
        set -a opts "󰂯  Turn on bluetooth"
    end

    for d in $connectedDevices
        set -a opts "󰂱  Disconnect from $d"
    end

    for d in $pairedDevices
        set -a opts "󰾰  Connect to $d"
    end

    for d in $devices
        set -a opts "󰾰  Connect to $d"
    end

    set selected (string join0 $opts | fuzzel --icon-theme=Tela-purple --dmenu0 --index)

    if test $status -ne 0
        return
    end

    if test $selected -eq 0
        if set -q on
            bluetoothctl power off
        else
            rfkill unblock bluetooth
            bluetoothctl power on
            sleep 0.1
            main
        end
    else if test $selected -eq 1
        bluetoothctl --timeout 10 scan on
        main
    else if test $selected -gt 1
        set -l connectedDevicesLength (count $connectedDevices)
        set -l pairedDevicesLength (count $pairedDevices)
        set -l devicesLength (count $devices)
        set -l selected (math $selected - 1) # To match the devices' arrays' indexes

        # TODO: pair devices?
        if test $selected -le $connectedDevicesLength
            echo "Connected device $connectedDevices[$index] $connectedDevicesIds[$selected]"
            bluetoothctl disconnect $connectedDevicesIds[$selected]
        else if test $selected -le (math $connectedDevicesLength + $pairedDevicesLength)
            set -l index (math $selected - $connectedDevicesLength)
            echo "Paired device $pairedDevices[$index] $pairedDevicesIds[$index]"
            bluetoothctl connect $pairedDevicesIds[$index]
        else if test $selected -le (math $connectedDevicesLength + $pairedDevicesLength + $devicesLength)
            set -l index (math $selected - $connectedDevicesLength - $pairedDevicesLength)
            echo "Device $devices[$index] $devicesIds[$index]"
            bluetoothctl connect $devicesIds[$index]
        end
    end
end
main
