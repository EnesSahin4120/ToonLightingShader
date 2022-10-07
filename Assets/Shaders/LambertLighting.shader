Shader "Custom/LambertLighting"
{
	Properties
	{
		_diffuseTex("Diffuse Texture", 2D) = "white" {}
		_color("Color", Color) = (1,1,1,1)
	}

    SubShader
	{
		CGPROGRAM
		#pragma surface surf Lambert 

		sampler2D _diffuseTex;
		fixed4 _color;

		struct Input 
		{
			float2 uv_diffuseTex;
		};

		void surf(Input IN, inout SurfaceOutput o) 
		{
			o.Albedo = _color.rgb * (tex2D(_diffuseTex, IN.uv_diffuseTex)).rgb;
		}
		ENDCG
	}
    Fallback "Diffuse"
}