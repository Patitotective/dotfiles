#!/usr/bin/env fish
if test (count $argv) -ne 1
    exit
end

set activeWorkspaceId (hyprctl -j activeworkspace | jq --raw-output '.id')
set activeWindowAddress (hyprctl -j activewindow | jq --raw-output '.address')

set firstChar (string sub --length=1 -- $argv[1])
if test $firstChar = "+" -o $firstChar = -
    set otherWorkspaceId (math -- $activeWorkspaceId $argv[1])
else
    set otherWorkspaceId $argv[1]
end

set clients (hyprctl -j clients)

set activeWorkspaceClientsAddresses (echo $clients | jq --raw-output ".[] | select(.workspace.id==$activeWorkspaceId) | .address")
set otherWorkspaceClientsAddresses (echo $clients | jq --raw-output ".[] | select(.workspace.id==$otherWorkspaceId) | .address")

set activeWorkspaceClientsSizes (echo $clients | jq --raw-output ".[] | select(.workspace.id==$activeWorkspaceId) | .size | join(\" \")")
set otherWorkspaceClientsSizes (echo $clients | jq --raw-output ".[] | select(.workspace.id==$otherWorkspaceId) | .size | join(\" \")")

for address in $activeWorkspaceClientsAddresses
    hyprctl dispatch movetoworkspacesilent $otherWorkspaceId,address:$address
end

# TODO: resize windows to their prev sizes, even though the order isn't maintained

# for i in (seq 1 (count $activeWorkspaceClientsSizes))
#     hyprctl dispatch resizewindowpixel exact $activeWorkspaceClientsSizes[$i],address:$activeWorkspaceClientsAddresses[$i]
# end

for address in $otherWorkspaceClientsAddresses
    hyprctl dispatch movetoworkspacesilent $activeWorkspaceId,address:$address
end

# for i in (seq 1 (count $otherWorkspaceClientsSizes))
#     hyprctl dispatch resizewindowpixel exact $otherWorkspaceClientsSizes[$i],address:$otherWorkspaceClientsAddresses[$i]
# end

hyprctl dispatch workspace $otherWorkspaceId
hyprctl dispatch focuswindow address:$activeWindowAddress
