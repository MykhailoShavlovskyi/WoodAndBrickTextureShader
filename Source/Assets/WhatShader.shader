Shader "Unlit/BaseShader" //This shader displays a red gradient
{
    Properties
    {
        _Texture("Main Texture", 2D) = "white" {}
        _waveHeight ("Wave Height", Range (0 ,20)) = 1
        _waveSpeed("Wave Speed",Range (0 ,200)) = 50
        _waveFrequency("Wave Frequency",Range (0 ,3.14)) = 0
        _waveRotation("Wave Rotation",Range (0 ,1)) = 0
    }
	SubShader 
	{
	    Tags {"Queue" = "Transparent"}
		Pass
		{
		    BLend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			float _waveHeight;
	        float _waveSpeed;
	        float _waveFrequency;
	        float _waveRotation;

			uniform sampler2D _Texture;

			struct AppData 
			{
				float4 position : POSITION; 
				float4 uv : TEXCOORD0; 
				float3 normal : NORMAL;

			};


			struct VertexToFragment 
			{
				float4 position : POSITION;
				float4 uv : TEXCOORD0;  
			};


			VertexToFragment vert (AppData v)
			{
			    float offset = v.position.x + v.position.y + v.position.z * _waveRotation;
			    float phase = _Time * _waveSpeed;

			    v.position.y = sin((phase + offset) * _waveFrequency) * (_waveHeight/2);

			    VertexToFragment output;
				output.position = mul(UNITY_MATRIX_MVP, v.position);
				output.uv = v.uv;
				return output;
			}


			float4 frag (VertexToFragment v) : SV_Target
			{
			    float4 color = tex2D(_Texture, v.uv);
			    color.a = 0.5;
			    return color;
			}
			ENDCG
		}
	}
    FallBack Off
}