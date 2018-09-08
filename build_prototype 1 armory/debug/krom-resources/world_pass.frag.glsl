#version 330
#ifdef GL_ARB_shading_language_420pack
#extension GL_ARB_shading_language_420pack : require
#endif

uniform sampler2D snoise;
uniform float time;
uniform vec3 backgroundCol;
uniform float envmapStrength;

out vec4 fragColor;
in vec3 normal;
vec3 traceP;

float noise(vec3 x)
{
    vec3 p = floor(x);
    vec3 f = fract(x);
    f = (f * f) * (vec3(3.0) - (f * 2.0));
    vec2 uv = (p.xy + (vec2(37.0, 17.0) * p.z)) + f.xy;
    vec2 rg = texture(snoise, (uv + vec2(0.5)) / vec2(256.0)).yx;
    return mix(rg.x, rg.y, f.z);
}

float fbm(inout vec3 p)
{
    p *= 0.0005000000237487256526947021484375;
    vec3 param = p;
    float f = 0.5 * noise(param);
    p *= 3.0;
    p.y += (time * 0.20000000298023223876953125);
    vec3 param_1 = p;
    f += (0.25 * noise(param_1));
    p *= 2.0;
    p.y += (time * 0.0599999986588954925537109375);
    vec3 param_2 = p;
    f += (0.125 * noise(param_2));
    p *= 3.0;
    vec3 param_3 = p;
    f += (0.0625 * noise(param_3));
    p *= 3.0;
    vec3 param_4 = p;
    f += (0.03125 * noise(param_4));
    p *= 3.0;
    vec3 param_5 = p;
    f += (0.015625 * noise(param_5));
    return f;
}

float map(vec3 p)
{
    vec3 param = p;
    float _170 = fbm(param);
    return _170 - 0.60000002384185791015625;
}

vec2 doCloudTrace(vec3 add, vec2 shadeSum)
{
    vec3 param = traceP;
    float h = map(param);
    vec2 shade = vec2(traceP.z / 1500.0, max(-h, 0.0));
    traceP += add;
    return shadeSum + (shade * (1.0 - shadeSum.y));
}

vec2 traceCloud(vec3 pos, vec3 dir)
{
    float beg = (2000.0 - pos.z) / dir.z;
    float end = (3500.0 - pos.z) / dir.z;
    traceP = vec3(pos.x + (dir.x * beg), pos.y + (dir.y * beg), 0.0);
    vec3 add = dir * ((end - beg) / 25.0);
    vec2 shadeSum = vec2(0.0);
    for (int i = 0; float(i) < 25.0; i++)
    {
        vec3 param = add;
        vec2 param_1 = shadeSum;
        vec2 _263 = doCloudTrace(param, param_1);
        shadeSum = _263;
        if (shadeSum.y >= 1.0)
        {
            return shadeSum;
        }
    }
    return shadeSum;
}

vec3 cloudsColor(vec3 R, vec3 pos, vec3 dir)
{
    vec3 param = pos;
    vec3 param_1 = dir;
    vec2 _282 = traceCloud(param, param_1);
    vec2 traced = _282;
    float d = ((traced.x / 200.0) * traced.y) + ((traced.x / 1500.0) * 0.0);
    float cosAngle = dot(vec3(0.0, -1.0, 0.0), dir);
    float E = (((2.0 * exp((-d) * 1.0)) * (1.0 - exp((-2.0) * d))) * 0.785398185253143310546875) * (0.63999998569488525390625 / pow(1.36000001430511474609375 - (1.2000000476837158203125 * cosAngle), 1.5));
    return mix(vec3(R), vec3(E * 24.0), vec3(d * 12.0));
}

void main()
{
    fragColor = vec4(backgroundCol.x, backgroundCol.y, backgroundCol.z, fragColor.w);
    vec3 n = normalize(normal);
    vec3 param = fragColor.xyz;
    vec3 param_1 = vec3(0.0);
    vec3 param_2 = n;
    vec3 _361 = cloudsColor(param, param_1, param_2);
    vec3 clouds = _361;
    if (n.z > 0.0)
    {
        vec3 _378 = mix(fragColor.xyz, clouds, vec3((n.z * 5.0) * envmapStrength));
        fragColor = vec4(_378.x, _378.y, _378.z, fragColor.w);
    }
}

