// From https://github.com/hyprwm/Hyprland/issues/1140#issuecomment-1546245134
// By ulziibuyan

precision highp float; // https://github.com/hyprwm/Hyprland/issues/1140#issuecomment-1950960827
varying vec2 v_texcoord;
uniform sampler2D tex;

void main() {
    vec4 pixColor = texture2D(tex, v_texcoord);

    gl_FragColor = vec4(
        pixColor[0] * 0.299 + pixColor[1] * 0.587 + pixColor[2] * 0.114,
        pixColor[0] * 0.299 + pixColor[1] * 0.587 + pixColor[2] * 0.114,
        pixColor[0] * 0.299 + pixColor[1] * 0.587 + pixColor[2] * 0.114,
        pixColor[3]
    );
}
