#version 450
#define _Irr
#define _EnvCol
#define _EnvClouds
#define _EnvStr
#define _Deferred
#define _CSM
#define _SSAO
in vec3 pos;
in vec3 nor;
in vec2 tex;
in vec3 tang;
out vec2 texCoord;
out mat3 TBN;
out vec3 wposition;
uniform mat3 N;
uniform mat4 WVP;
uniform mat4 W;
void main() {
    vec4 spos = vec4(pos, 1.0);
texCoord = tex;
wposition = vec4(W * spos).xyz;
	vec3 wnormal = normalize(N * nor);
	gl_Position = WVP * spos;
	vec3 tangent = normalize(N * tang);
	vec3 bitangent = normalize(cross(wnormal, tangent));
	TBN = mat3(tangent, bitangent, wnormal);
}
