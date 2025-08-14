#!/bin/fish
function setShader
    hyprctl --quiet keyword decoration:screen_shader "$argv[1]"
end

set curShader (hyprctl -j getoption decoration:screen_shader | jq --raw-output '.set, .str')
#   curShader[1] is whether or not a custom shader is set
#   cursShader[2] is the path to the shader
set shaders ~/.config/hypr/shaders/*
set index (contains --index $curShader[2] $shaders or echo 0)
if test (count $argv) -gt 0
    set directionArg $argv[1]
else
    set directionArg 1
end

if test $directionArg -gt 0
    set direction true
else
    set direction false
end

echo $index
if test $direction = true
    if test $index -ge (count $shaders)
        setShader $shaders[1]
    else
        setShader $shaders[(math $index + 1)]
    end
else
    if test $index -le 1
        setShader $shaders[(count $shaders)]
    else
        setShader $shaders[(math $index - 1)]
    end
end
