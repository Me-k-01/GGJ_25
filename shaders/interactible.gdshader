shader_type spatial;
 
uniform float spin_speed : hint_range(0, 10) = 1.0; // Speed of spinning
uniform float bounce_amplitude : hint_range(0, 1) = 0.5; // Amplitude of bounce
uniform float bounce_frequency : hint_range(0, 10) = 1.0; // Frequency of bounce

uniform sampler2D asset_texture;

//uniform vec4 color1 : source_color;
uniform vec4 base_color : source_color = vec4(1.0, 0.679, 0.23, 1.0);
//uniform float threshold;
//uniform float intensity;
//uniform float opacity;
//uniform vec4 glow_color : source_color;

float fresnel(float amount, vec3 normal, vec3 view)
{
	return pow((1.0 - clamp(dot(normalize(normal), normalize(view)), 0.0, 1.0 )), amount);
}
vec3 fresnel_glow(float amount, float intensity, vec3 color, vec3 normal, vec3 view)
{
	return pow((1.0 - dot(normalize(normal), normalize(view))), amount) * color * intensity;
}
 

vec3 convert_to_spin(vec3 v) { 
    // Make the mesh spin
    float angle = TIME * spin_speed; // Angle of rotation
    float cos_angle = cos(angle);
    float sin_angle = sin(angle);
    
    // Rotate around the Y-axis (xz-plane rotation)
    float x = v.x * cos_angle - v.z * sin_angle;
    float z = v.x * sin_angle + v.z * cos_angle;
    v.x = x;
    v.z = z;

    // Add bounce effect
    v.y += sin(TIME * bounce_frequency) * bounce_amplitude;
	return v;
}
void vertex() {  
	VERTEX = convert_to_spin(VERTEX);
	NORMAL = convert_to_spin(NORMAL); 
}
void fragment() { 
	ALBEDO = texture(asset_texture, UV).rgb;
	//ALPHA = fresnel(3.0, NORMAL, VIEW);
	EMISSION = fresnel(3.0, NORMAL, VIEW) * base_color.rgb *10.0;
}
	
