Shader "Custom/ToonLighting"
{
	Properties
	{
		_paletteTex("Palette Texture", 2D) = "white" {}
	    _diffuseTex("Diffuse Texture", 2D) = "white" {}
		_color("Color", Color) = (1,1,1,1)
	    _normalTex("Normal Texture", 2D) = "white" {}
	}

	SubShader
	{
		CGPROGRAM
		#pragma surface surf Toon

	    sampler2D _paletteTex;
		sampler2D _diffuseTex;
		fixed4 _color;
		sampler2D _normalTex;

		float4 LightingToon(SurfaceOutput s, fixed3 lightDir, fixed atten)
		{
			float diffuse = dot(s.Normal, lightDir);
			float h = diffuse * 0.7 + 0.3;
			float2 rh = h;
			float3 palette = tex2D(_paletteTex, rh).rgb;

			float4 c;
			c.rgb = s.Albedo * palette * _LightColor0.rgb;
			c.a = s.Alpha;
			return c;
		}

		struct Input
		{
			float2 uv_diffuseTex;
			float2 uv_normalTex;
		};

		void surf(Input IN, inout SurfaceOutput o) 
		{
			o.Albedo = _color.rgb * (tex2D(_diffuseTex, IN.uv_diffuseTex)).rgb;
			o.Normal = UnpackNormal(tex2D(_normalTex, IN.uv_normalTex));
		}
		ENDCG
	}
	FallBack "Diffuse"
}