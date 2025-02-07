shader_type canvas_item;

uniform bool flash = false;  // Variável para controlar o efeito de piscar

void fragment() {
    vec4 color = texture(TEXTURE, UV);  // Cor original do sprite
    if (flash) {
        color.rgb = vec3(1.0, 1.0, 1.0);  // Muda a cor para branco
    }
    COLOR = color;
}