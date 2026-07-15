using Godot;
using System;
using System.Collections.Generic;

public partial class Root : Node2D
{
	
	MainScreen _mainScreen;
	Node2D _playScreen;
	private Button _back;
	private Label _score;
	
	public override void _Ready()
	{
		_mainScreen = GetNode<MainScreen>("MainScreen");
		_playScreen = GetNode<Node2D>("LEVELS");
		_back = GetNode<Button>("Back");
		_score = GetNode<Label>("Score");
		
		CustomSignals._Instance.StartLevel += StartLevel;
		_back.Pressed += Reset;
		CustomSignals._Instance.Reset += Reset;
	}

	public override void _Process(double delta)
	{
		GetNode<Label>("Score").Text = $"Score:\n {Globals.SCORE}";
	}

	public void StartLevel(int level)
	{
		_mainScreen.Visible = false;
		_playScreen.Visible = true;
		_back.Visible = true;
		_score.Visible = true;

		foreach (Node2D child in _playScreen.GetChildren())
		{
			child.Visible = false;
		}
		
		_playScreen.GetChild<Node2D>(level).Visible = true;
	}

	public void Reset()
	{
		_back.Visible = false;
		_score.Visible = false;
		_playScreen.Visible = false;
		_mainScreen.Visible = true;
		
		foreach (PlayScreen screen in GetNode("LEVELS").GetChildren())
		{
			screen.SetScene();
		}
		
	}
}
