Shader "Unlit/BaseShader" //This shader displays a red gradient
{

 Properties
 {
   _ColorA ("Color 1", Color) = (.769, .640, .209, 0)
   _ColorB ("Color 2", Color) = (.631, .498, .070, 0)
   _rings ("Amount of rings", Range (3 ,15)) = 7
 }

 SubShader {
  
  Pass {
   CGPROGRAM

   #pragma vertex vert
   #pragma fragment frag

   float4 _ColorA;
   float4 _ColorB;
   float _rings;

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
    o.uv = v.uv;
    o.normal = mul(_World2Object, v.normal);
    return o;
   }
   
  
   float4 frag (VertexToFragment v) : SV_Target
   {
     float LocalX = v.uv.x-0.5;    //Distance From The Center
     float LocalY = v.uv.y-0.5;

     if(v.normal.y != 0)
     {
	    LocalY = 0.5;
	 }

	 if(v.normal.x !=0)
	 {
	    LocalX = 0.5;
	 }

	 float stepSize = 0.5/_rings;
	 float currentRadious = sqrt (LocalX * LocalX + LocalY * LocalY);

	 float gradient =  1.5f - ((currentRadious%stepSize)/stepSize);
	 bool evenRing = ( currentRadious%(stepSize*2) < stepSize);

	 _ColorA = _ColorA * gradient;
	 _ColorB = _ColorB * gradient;

	 if(evenRing)
	 {
	    return _ColorA; 
	 }
	 else
	 {  
	    return _ColorB; 
	 }

   }
   ENDCG
  }
 }
 FallBack Off
}