// Taken from https://www.reddit.com/r/hyprland/comments/1es6xdk/comment/li4542l/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
// By Rcomian
precision mediump float;
varying vec2 v_texcoord;
uniform sampler2D tex;

void main() {
  vec4 this_colour = texture2D( tex, v_texcoord ); 
  float new_colour = (this_colour.r+this_colour.g+this_colour.b)/3.0;
  gl_FragColor = vec4(new_colour,new_colour,new_colour,1.0);
}
