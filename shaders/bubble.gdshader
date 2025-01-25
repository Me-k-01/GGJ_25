shader_type spatial;
render_mode cull_disabled;

uniform sampler2D noise_texture; // Displacement noise
uniform sampler2D color_texture; // Rainbow color of the bubble
uniform float bubble_patern_scale  : hint_range(0.1, 1.0, 0.01);
uniform float distortion_smoothness  : hint_range(0.0, 1.0, 0.01); // Scale
uniform float distortion_power  : hint_range(0.0, 1.0, 0.01);
uniform float distortion_speed  : hint_range(0.0, 1.0, 0.01);
uniform vec4 base_color : source_color = vec4(1.0);

varying vec3 world_position;

void vertex() {
	world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
	float height = texture(noise_texture, VERTEX.xz * distortion_smoothness + vec2(TIME * 0.1 * distortion_speed)).r;
	VERTEX += NORMAL * height * distortion_power;
}
float fresnel(float amount, vec3 normal, vec3 view)
{
	return pow((1.0 - clamp(dot(normalize(normal), normalize(view)), 0.0, 1.0 )), amount);
}
vec3 fresnel_glow(float amount, float intensity, vec3 color, vec3 normal, vec3 view)
{
	return pow((1.0 - dot(normalize(normal), normalize(view))), amount) * color * intensity;
}


void fragment()
{
		vec3 rainbow = texture(color_texture, VERTEX.xy * bubble_patern_scale + vec2(TIME * 0.1 * distortion_speed)).rgb;

	float basic_fresnel = fresnel(3.0, NORMAL, VIEW);

	vec3 fresnel = fresnel_glow(4.0, 4.5, base_color.rgb, NORMAL, VIEW);
	ALPHA = basic_fresnel + 0.05f;
	ALBEDO = (base_color.rgb + fresnel)*rainbow;

}

 //
//
//void light() {
	 ////Called for every pixel for every light affecting the material.
	 ////Uncomment to replace the default light processing function with this one.
//}
