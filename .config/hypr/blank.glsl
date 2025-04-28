// Taken from https://github.com/hyprwm/Hyprland/issues/1140#issuecomment-1622495967
// By MahouShoujoMivutilde
// blank shader

precision mediump float;
varying vec2 v_texcoord;
uniform sampler2D tex;

void main() {
    vec4 pixColor = texture2D(tex, v_texcoord);
    gl_FragColor = pixColor;
}
