#ifndef _COMPILED_GLSL_
#define _COMPILED_GLSL_
#define _Irr
#define _EnvCol
#define _EnvClouds
#define _EnvStr
#define _Deferred
#define _CSM
#define _SSAO
#define _CToneFilmic
#define _CFXAA
#define _CTexStep
const float PI = 3.1415926535;
const float PI2 = PI * 2.0;
const vec2 shadowmapSize = vec2(1024, 1024);
const float shadowmapCubePcfSize = 0.001;
const int shadowmapCascades = 4;
const float cloudsDensity = 1.0;
const float cloudsSize = 1.0;
const float cloudsLower = 2000;
const float cloudsUpper = 3500;
const vec2 cloudsWind = vec2(0.2, 0.06);
const float cloudsSecondary = 0.0;
const float cloudsPrecipitation = 1.0;
const float cloudsEccentricity = 0.6;
const float ssaoSize = 0.12;
const float ssaoStrength = 0.1;
const float ssaoTextureScale = 1.0;
const float bloomThreshold = 1.0;
const float bloomStrength = 3.5;
const float bloomRadius = 3.0;
const int skinMaxBones = 8;

#endif // _COMPILED_GLSL_
