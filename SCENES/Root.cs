using Godot;
using System;
using System.Collections.Generic;

public partial class Root : Node2D
{
	
	MainScreen _mainScreen;
	Node2D _playScreen;

	private Dictionary<int, Vector2> _levelConfigurations = new Dictionary<int, Vector2>()
	{
		{ 1, new Vector2(2, 3) },
		{ 2, new Vector2(3, 3) },
		{ 3, new Vector2(3, 4) },
		{ 4, new Vector2(4, 4) },
		{ 5, new Vector2(6, 6) }
	};
	
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		_mainScreen = GetNode<MainScreen>("MainScreen");
		_playScreen = GetNode<Node2D>("LEVELS");
		
		CustomSignals._Instance.StartLevel += StartLevel;
	}



	public void StartLevel(int level)
	{
		_mainScreen.Visible = false;
		_playScreen.Visible = true;

		foreach (Node2D child in _playScreen.GetChildren())
		{
			child.Visible = false;
		}
		
		_playScreen.GetChild<Node2D>(level).Visible = true;
	}
}
