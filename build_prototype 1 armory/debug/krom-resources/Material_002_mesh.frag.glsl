#version 330
#ifdef GL_ARB_shading_language_420pack
#extension GL_ARB_shading_language_420pack : require
#endif

uniform sampler2D ImageTexture;
uniform sampler2D ImageTexture_002;
uniform sampler2D ImageTexture_001;

in vec3 wposition;
in mat3 TBN;
out vec4 fragColor[2];
in vec2 texCoord;

vec2 octahedronWrap(vec2 v)
{
    return (vec2(1.0) - abs(v.yx)) * vec2((v.x >= 0.0) ? 1.0 : (-1.0), (v.y >= 0.0) ? 1.0 : (-1.0));
}

float packFloat(float f1, float f2)
{
    return floor(f1 * 100.0) + min(f2, 0.9900000095367431640625);
}

float packFloat2(float f1, float f2)
{
    return floor(f1 * 255.0) + min(f2, 0.9900000095367431640625);
}

void main()
{
    vec3 Geometry_Position_res_wt = wposition;
    vec3 Mapping_Vector_res_wt = (Geometry_Position_res_wt * vec3(0.5)) + vec3(0.4999999701976776123046875, -0.4999999701976776123046875, 0.0);
    vec4 ImageTexture_store = texture(ImageTexture, vec2(Mapping_Vector_res_wt.x, 1.0 - Mapping_Vector_res_wt.y));
    vec3 _92 = pow(ImageTexture_store.xyz, vec3(2.2000000476837158203125));
    ImageTexture_store = vec4(_92.x, _92.y, _92.z, ImageTexture_store.w);
    vec4 ImageTexture_002_store = texture(ImageTexture_002, vec2(Mapping_Vector_res_wt.x, 1.0 - Mapping_Vector_res_wt.y));
    vec4 ImageTexture_001_store = texture(ImageTexture_001, vec2(Mapping_Vector_res_wt.x, 1.0 - Mapping_Vector_res_wt.y));
    vec3 ImageTexture_001_Color_res = ImageTexture_001_store.xyz;
    vec3 n = (ImageTexture_001_Color_res * 2.0) - vec3(1.0);
    n = normalize(TBN * n);
    vec3 ImageTexture_Color_res = ImageTexture_store.xyz;
    vec3 ImageTexture_002_Color_res = ImageTexture_002_store.xyz;
    vec3 basecol = ImageTexture_Color_res;
    float roughness = ImageTexture_002_Color_res.x;
    float metallic = 0.0;
    float occlusion = 1.0;
    float specular = 1.0;
    n /= vec3((abs(n.x) + abs(n.y)) + abs(n.z));
    vec2 _164;
    if (n.z >= 0.0)
    {
        _164 = n.xy;
    }
    else
    {
        _164 = octahedronWrap(n.xy);
    }
    n = vec3(_164.x, _164.y, n.z);
    fragColor[0] = vec4(n.xy, packFloat(metallic, roughness), 1.0 - gl_FragCoord.z);
    fragColor[1] = vec4(basecol, packFloat2(occlusion, specular));
}

