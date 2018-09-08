#version 330
#ifdef GL_ARB_shading_language_420pack
#extension GL_ARB_shading_language_420pack : require
#endif

uniform mat4 W;
uniform mat3 N;
uniform mat4 WVP;

in vec3 pos;
out vec2 texCoord;
in vec2 tex;
out vec3 wposition;
in vec3 nor;
in vec3 tang;
out mat3 TBN;

void main()
{
    vec4 spos = vec4(pos, 1.0);
    texCoord = tex;
    wposition = vec4(W * spos).xyz;
    vec3 wnormal = normalize(N * nor);
    gl_Position = WVP * spos;
    vec3 tangent = normalize(N * tang);
    vec3 bitangent = normalize(cross(wnormal, tangent));
    TBN = mat3(vec3(tangent), vec3(bitangent), vec3(wnormal));
}

