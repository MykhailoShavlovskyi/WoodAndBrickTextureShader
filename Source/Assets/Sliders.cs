using UnityEngine;
using UnityEngine.UI;
using System.Collections;
using System.Collections.Generic;
public class Sliders : MonoBehaviour 
{
	[SerializeField ]private List<Slider> colorASliders;
	[SerializeField ]private List<Slider> colorBSliders;

	[SerializeField] private GameObject bricks;
	[SerializeField] private GameObject wood;

	void Update()
	{
		foreach (Renderer rend in wood.GetComponentsInChildren<Renderer>()) 
		{
			rend.material.SetColor ("_ColorA",new Color(colorASliders[0].value, colorASliders[1].value, colorASliders[2].value));
			rend.material.SetColor ("_ColorB",new Color(colorBSliders[0].value, colorBSliders[1].value, colorBSliders[2].value));
		}
	}

	public void ChangeRowsCount(Slider slider)
	{
		ChangeShaderParameter (bricks, "_rowsCount", slider.value);
	}
	public void ChangeCollumsCount(Slider slider)
	{
		ChangeShaderParameter (bricks, "_collumsCount", slider.value);
	}
	public void ChangeDistanceBetweenBricks(Slider slider)
	{
		ChangeShaderParameter (bricks, "_distanceBetweenBricks", slider.value);
	}

	public void ChangeAmountOfRings(Slider slider)
	{
		ChangeShaderParameter (wood, "_rings", slider.value);
	}

	private void ChangeShaderParameter(GameObject parent, string parameterName, float value)
	{
		foreach (Renderer rend in parent.GetComponentsInChildren<Renderer>()) 
		{
			rend.material.SetFloat (parameterName, value);
		}
	}
}
