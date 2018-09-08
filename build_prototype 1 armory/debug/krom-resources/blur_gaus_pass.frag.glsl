#version 330
#ifdef GL_ARB_shading_language_420pack
#extension GL_ARB_shading_language_420pack : require
#endif

uniform vec2 dir;
uniform vec2 screenSize;
uniform sampler2D tex;

out vec4 fragColor;
in vec2 texCoord;

void main()
{
    vec2 _step = (dir / screenSize) * 3.0;
    vec3 _33 = texture(tex, texCoord).xyz * 0.132571995258331298828125;
    fragColor = vec4(_33.x, _33.y, _33.z, fragColor.w);
    vec3 _48 = fragColor.xyz + (texture(tex, texCoord + (_step * 1.5)).xyz * 0.12547199428081512451171875);
    fragColor = vec4(_48.x, _48.y, _48.z, fragColor.w);
    vec3 _61 = fragColor.xyz + (texture(tex, texCoord - (_step * 1.5)).xyz * 0.12547199428081512451171875);
    fragColor = vec4(_61.x, _61.y, _61.z, fragColor.w);
    vec3 _76 = fragColor.xyz + (texture(tex, texCoord + (_step * 2.5)).xyz * 0.10637299716472625732421875);
    fragColor = vec4(_76.x, _76.y, _76.z, fragColor.w);
    vec3 _89 = fragColor.xyz + (texture(tex, texCoord - (_step * 2.5)).xyz * 0.10637299716472625732421875);
    fragColor = vec4(_89.x, _89.y, _89.z, fragColor.w);
    vec3 _104 = fragColor.xyz + (texture(tex, texCoord + (_step * 3.5)).xyz * 0.0807799994945526123046875);
    fragColor = vec4(_104.x, _104.y, _104.z, fragColor.w);
    vec3 _117 = fragColor.xyz + (texture(tex, texCoord - (_step * 3.5)).xyz * 0.0807799994945526123046875);
    fragColor = vec4(_117.x, _117.y, _117.z, fragColor.w);
    vec3 _132 = fragColor.xyz + (texture(tex, texCoord + (_step * 4.5)).xyz * 0.0549499988555908203125);
    fragColor = vec4(_132.x, _132.y, _132.z, fragColor.w);
    vec3 _145 = fragColor.xyz + (texture(tex, texCoord - (_step * 4.5)).xyz * 0.0549499988555908203125);
    fragColor = vec4(_145.x, _145.y, _145.z, fragColor.w);
    vec3 _160 = fragColor.xyz + (texture(tex, texCoord + (_step * 5.5)).xyz * 0.03348200023174285888671875);
    fragColor = vec4(_160.x, _160.y, _160.z, fragColor.w);
    vec3 _173 = fragColor.xyz + (texture(tex, texCoord - (_step * 5.5)).xyz * 0.03348200023174285888671875);
    fragColor = vec4(_173.x, _173.y, _173.z, fragColor.w);
    vec3 _188 = fragColor.xyz + (texture(tex, texCoord + (_step * 6.5)).xyz * 0.018275000154972076416015625);
    fragColor = vec4(_188.x, _188.y, _188.z, fragColor.w);
    vec3 _201 = fragColor.xyz + (texture(tex, texCoord - (_step * 6.5)).xyz * 0.018275000154972076416015625);
    fragColor = vec4(_201.x, _201.y, _201.z, fragColor.w);
    vec3 _216 = fragColor.xyz + (texture(tex, texCoord + (_step * 7.5)).xyz * 0.008933999575674533843994140625);
    fragColor = vec4(_216.x, _216.y, _216.z, fragColor.w);
    vec3 _229 = fragColor.xyz + (texture(tex, texCoord - (_step * 7.5)).xyz * 0.008933999575674533843994140625);
    fragColor = vec4(_229.x, _229.y, _229.z, fragColor.w);
    vec3 _244 = fragColor.xyz + (texture(tex, texCoord + (_step * 8.5)).xyz * 0.00391199998557567596435546875);
    fragColor = vec4(_244.x, _244.y, _244.z, fragColor.w);
    vec3 _257 = fragColor.xyz + (texture(tex, texCoord - (_step * 8.5)).xyz * 0.00391199998557567596435546875);
    fragColor = vec4(_257.x, _257.y, _257.z, fragColor.w);
    vec3 _272 = fragColor.xyz + (texture(tex, texCoord + (_step * 9.5)).xyz * 0.00153500004671514034271240234375);
    fragColor = vec4(_272.x, _272.y, _272.z, fragColor.w);
    vec3 _285 = fragColor.xyz + (texture(tex, texCoord - (_step * 9.5)).xyz * 0.00153500004671514034271240234375);
    fragColor = vec4(_285.x, _285.y, _285.z, fragColor.w);
    vec3 _291 = fragColor.xyz * 0.699999988079071044921875;
    fragColor = vec4(_291.x, _291.y, _291.z, fragColor.w);
}

