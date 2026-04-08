varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	vec4 colour = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	colour.rgb = vec3(0.0, 1.0, 0.0);
	
    gl_FragColor = colour;
}