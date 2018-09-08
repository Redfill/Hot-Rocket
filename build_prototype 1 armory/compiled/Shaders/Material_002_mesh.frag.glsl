#version 450
#define _Irr
#define _EnvCol
#define _EnvClouds
#define _EnvStr
#define _Deferred
#define _CSM
#define _SSAO
#include "compiled.inc"
#include "std/gbuffer.glsl"
in vec2 texCoord;
in mat3 TBN;
in vec3 wposition;
out vec4[2] fragColor;
uniform sampler2D ImageTexture;
uniform sampler2D ImageTexture_002;
uniform sampler2D ImageTexture_001;
void main() {
	vec3 Geometry_Position_res_wt = wposition;
	vec3 Mapping_Vector_res_wt = ((Geometry_Position_res_wt * vec3(0.5, 0.5, 0.5)) + vec3(0.4999999701976776, -0.4999999701976776, 0.0));
	vec4 ImageTexture_store = texture(ImageTexture, vec2(Mapping_Vector_res_wt.x, 1.0 - Mapping_Vector_res_wt.y).xy);
	ImageTexture_store.rgb = pow(ImageTexture_store.rgb, vec3(2.2));
	vec4 ImageTexture_002_store = texture(ImageTexture_002, vec2(Mapping_Vector_res_wt.x, 1.0 - Mapping_Vector_res_wt.y).xy);
	vec4 ImageTexture_001_store = texture(ImageTexture_001, vec2(Mapping_Vector_res_wt.x, 1.0 - Mapping_Vector_res_wt.y).xy);
	vec3 ImageTexture_001_Color_res = ImageTexture_001_store.rgb;
	vec3 n = (ImageTexture_001_Color_res) * 2.0 - 1.0;
	n = normalize(TBN * n);
	vec3 basecol;
	float roughness;
	float metallic;
	float occlusion;
	float specular;
	vec3 ImageTexture_Color_res = ImageTexture_store.rgb;
	vec3 ImageTexture_002_Color_res = ImageTexture_002_store.rgb;
	basecol = ImageTexture_Color_res;
	roughness = ImageTexture_002_Color_res.x;
	metallic = 0.0;
	occlusion = 1.0;
	specular = 1.0;
	n /= (abs(n.x) + abs(n.y) + abs(n.z));
	n.xy = n.z >= 0.0 ? n.xy : octahedronWrap(n.xy);
	fragColor[0] = vec4(n.xy, packFloat(metallic, roughness), 1.0 - gl_FragCoord.z);
	fragColor[1] = vec4(basecol.rgb, packFloat2(occlusion, specular));
}
