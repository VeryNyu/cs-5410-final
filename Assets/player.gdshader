shader_type canvas_item;

uniform float speed = 3;
uniform vec4 hurt_color : source_color = vec4(1.0, 1.0, 1.0, 0.5); // Pale red
uniform bool is_hurt = false;
uniform bool is_invincible = false;
uniform float start_time = 0.0;

void fragment() {
    // Grab the normal sprite color and transparency
    vec4 tex_color = texture(TEXTURE, UV);

    //if (is_invincible) {
        //// I-Frames: Multiply by red (keeps the sprite's shape/transparency intact)
        //COLOR = tex_color * vec4(1.0, 0.0, 0.0, 1.0);
    //} 
    //else 
	if (is_hurt) {
        // 1-Health Pulse: sin() guarantees we start at exactly 0.0 (tex_color)
        float pulse = (cos((TIME - start_time) * speed) + 1.0) / 2.0;
        
        // Smoothly mix between the normal color and the red hurt color
        COLOR = mix(tex_color, tex_color * hurt_color, pulse);
    } 
    else {
        // Normal 2-Health state
        COLOR = tex_color;
    }
}