Shader "Unlit/BaseShader" //This shader displays a red gradient
{
    Properties
    {
        _rowsCount ("Rows Count", Range (1 ,25)) = 12
        _collumsCount("Collums Count",Range (1 ,25)) = 5
        _distanceBetweenBricks("Distance Between Bricks",Range (0.01 ,0.05)) = 0.03
    }

    SubShader 
    {
        Pass 
        {
	        CGPROGRAM

	        #pragma vertex vert
	        #pragma fragment frag

	        float _rowsCount;
	        float _collumsCount;
	        float _distanceBetweenBricks;

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
			    float3 normal : NORMAL;
		    };

	 
		    VertexToFragment vert (AppData v) 
		    {
			    VertexToFragment o;
			    o.position = mul(UNITY_MATRIX_MVP, v.position);
			    o.normal = mul(_World2Object, v.normal);
			    o.uv = v.uv;
			    return o;
		    }
	   
	  
		    float4 frag (VertexToFragment v) : SV_Target
		    {
			    float LocalX = v.uv.x;    //Distance From The Center
			    float LocalY = v.uv.y;

			    if(v.normal.x !=0 | v.normal.z == 1)
			    {
			        LocalX = 1 - LocalX;
		            LocalY = 1 - LocalY;
		        }

			    if(LocalY % (1 / _rowsCount) < _distanceBetweenBricks 
			    ||(LocalY % ((1 / _rowsCount) * 2) < 1 / _rowsCount  &&  (LocalX % (1 / _collumsCount) < _distanceBetweenBricks)) 
			    ||( LocalY % ((1 / _rowsCount) * 2) > 1 / _rowsCount  &&  ((LocalX+(1 / _collumsCount/2)) % (1 / _collumsCount) < _distanceBetweenBricks)))
			    {
			 		return float4(0,0,0,0);  //black
			    }
			    else
			    {
				    return float4(0.5f,0.1f,0,0); //red
				}
				
		    }
        ENDCG
        }
    }
FallBack Off
}