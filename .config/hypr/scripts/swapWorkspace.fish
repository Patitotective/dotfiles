#!/usr/bin/env fish
if test (count $argv) -ne 1
    exit
end

set activeWorkspaceId (hyprctl -j activeworkspace | jq --raw-output '.id')

set firstChar (string sub --length=1 -- $argv[1])
if test $firstChar = "+" -o $firstChar = -
    set otherWorkspaceId (math -- $activeWorkspaceId $argv[1])
else
    set otherWorkspaceId $argv[1]
end

set clients (hyprctl -j clients)

set activeWorkspaceClientsAddresses (echo $clients | jq --raw-output ".[] | select(.workspace.id==$activeWorkspaceId) | .address")
set otherWorkspaceClientsAddresses (echo $clients | jq --raw-output ".[] | select(.workspace.id==$otherWorkspaceId) | .address")

for address in $activeWorkspaceClientsAddresses
    hyprctl dispatch movetoworkspacesilent $otherWorkspaceId,address:$address
end

for address in $otherWorkspaceClientsAddresses
    hyprctl dispatch movetoworkspacesilent $activeWorkspaceId,address:$address
end

hyprctl dispatch workspace $otherWorkspaceId
