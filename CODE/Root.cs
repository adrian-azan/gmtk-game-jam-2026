using Godot;
using System;
using System.Collections.Generic;

public partial class Root : Node2D
{
	
	MainScreen _mainScreen;
	Node2D _playScreen;
	private Button _back;
	
	public override void _Ready()
	{
		_mainScreen = GetNode<MainScreen>("MainScreen");
		_playScreen = GetNode<Node2D>("LEVELS");
		_back = GetNode<Button>("Back");
		
		CustomSignals._Instance.StartLevel += StartLevel;
		_back.Pressed += Reset;
		CustomSignals._Instance.Reset += Reset;
	}

	public void StartLevel(int level)
	{
		_mainScreen.Visible = false;
		_playScreen.Visible = true;
		_back.Visible = true;

		foreach (Node2D child in _playScreen.GetChildren())
		{
			child.Visible = false;
		}
		
		_playScreen.GetChild<Node2D>(level).Visible = true;
	}

	public void Reset()
	{
		_back.Visible = false;
		_playScreen.Visible = false;
		_mainScreen.Visible = true;
		foreach (PlayScreen screen in GetNode("LEVELS").GetChildren())
		{
			screen.SetScene();
		}
		
	}
}
