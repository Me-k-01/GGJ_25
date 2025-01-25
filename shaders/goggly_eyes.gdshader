shader_type spatial;

uniform sampler2D back_eye_texture;
uniform sampler2D iris_eye_texture;
uniform sampler2D light_eye_texture;

uniform float jiggle_intensity = 0.05; // How much the eye jiggles
uniform float speed = 2.0; // Speed of the jiggle
varying vec3 world_position;
uniform vec2 eye_center = vec2(0.5, 0.5); // Center of the googly eye in UV space

uniform bool teary_eye;

void vertex() {
	// Called for every vertex the material is visible on. 
	//world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
    world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
	//world_position = (MODELVIEW_NORMAL_MATRIX * (VERTEX)).xyz;
	//world_position = (MODELVIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
}

void fragment() {
	// Called for every pixel the material is visible on. 
	//ALBEDO = vec3(1.0);
	//vec3 iris = texture(iris_eye_texture, vec2((VIEW).xy) * 5.0 ).rgb;
	 
	
	float iris; vec3 eye_back; vec3 light_eye_back;
	
	if (teary_eye) { 
	    float offset_x = sin(TIME * 2.0 + UV.y * 10.0) * 0.05;
	    float offset_y = cos(TIME * 2.0 + UV.x * 10.0) * 0.05;

	    // Apply the offset to the UV coordinates, centered around the eye
	    vec2 teary_eye_uv = UV + vec2(offset_x, offset_y) ;
		iris = texture(iris_eye_texture, teary_eye_uv ).r;
		eye_back = texture(back_eye_texture, teary_eye_uv   ).rgb;
		light_eye_back = texture(light_eye_texture, teary_eye_uv   ).rgb;
	} else { 
	    float offset_x = sin(TIME * speed ) * jiggle_intensity;
	    float offset_y = cos(TIME * speed ) * jiggle_intensity;
		 
	    vec2 jiggle_eye_uv = UV + vec2(offset_x, offset_y) ;
 
		iris = texture(iris_eye_texture, jiggle_eye_uv ).r;
		eye_back = texture(back_eye_texture, UV   ).rgb;
		light_eye_back = texture(light_eye_texture, UV   ).rgb;
	}
	//ALBEDO = texture(eye_texture, (vec2(world_position.xy) ) *2.1 + vec2(0.5, 0.42) ).rgb;
	//ALBEDO = texture(eye_texture, (vec2(world_position.xy) *2.1)   ).rgb;
	ALBEDO = (eye_back - (4.0*iris) + light_eye_back);
	ALPHA = eye_back.r;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
