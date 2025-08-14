#version 300 es
// Taken from https://github.com/3P1L-0/Hyprland-HyDE/tree/9583656ae96860d926563871910ec10f0b921166/Configs/.config/hypr/shaders/disable.frag
precision mediump float;

in vec2 v_texcoord;
out vec4 fragColor;

uniform sampler2D tex;

void main() {
    fragColor = texture(tex, v_texcoord);
}
