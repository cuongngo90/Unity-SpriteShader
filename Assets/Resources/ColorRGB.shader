﻿//////////////////////////////////////////////
/// 2DxFX - 2D SPRITE FX - by VETASOFT 2015 //
/// http://unity3D.vetasoft.com/            //
//////////////////////////////////////////////

Shader "Custom/ColorRGB"
{
Properties
{
_MainTex ("Base (RGB)", 2D) = "white" {}
_Color ("_Color", Color) = (1,1,1,1)
_ColorR ("ColorR", Range(0,1)) = 0
_ColorG ("ColorG", Range(0,1)) = 0
_ColorB ("ColorB", Range(0,1)) = 0
_Size ("Size", Range(0,1)) = 0
_Alpha ("Alpha", Range (0,1)) = 1.0
}

SubShader
{

Tags {"Queue"="Transparent" "IgnoreProjector"="true" "RenderType"="Transparent"}
ZWrite Off Blend SrcAlpha OneMinusSrcAlpha Cull Off


Pass
{

CGPROGRAM
#pragma vertex vert
#pragma fragment frag
#pragma fragmentoption ARB_precision_hint_fastest
#pragma target 3.0
#include "UnityCG.cginc"

struct appdata_t
{
float4 vertex   : POSITION;
float4 color    : COLOR;
float2 texcoord : TEXCOORD0;
};

struct v2f
{
half2 texcoord  : TEXCOORD0;
float4 vertex   : SV_POSITION;
fixed4 color    : COLOR;
};


sampler2D _MainTex;
fixed4 _Color;
float _ColorR;
float _ColorG;
float _ColorB;
fixed _Alpha;

v2f vert(appdata_t IN)
{
v2f OUT;
OUT.vertex = mul(UNITY_MATRIX_MVP, IN.vertex);
OUT.texcoord = IN.texcoord;
OUT.color = IN.color;

return OUT;
}


float4 frag (v2f i) : COLOR
{
	float2 uv =  i.texcoord;
  	float4 tex = tex2D(_MainTex, uv)*i.color * _Color;
	   
  	
 	tex.r+=_ColorR;
	tex.g+=_ColorG;
	tex.b+=_ColorB;
  
	return float4(tex.rgb,tex.a*1-_Alpha);
}

ENDCG
}
}
Fallback "Sprites/Default"

}