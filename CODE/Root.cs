using Godot;
using System;
using System.Collections.Generic;

public partial class Root : Node2D
{
	
	MainScreen _mainScreen;
	Node2D _playScreen;
	private Button _back;
	private Label _score;

	private float _musicPosition;
	
	public override void _Ready()
	{
		_mainScreen = GetNode<MainScreen>("MainScreen");
		_playScreen = GetNode<Node2D>("LEVELS");
		_back = GetNode<Button>("Back");
		_score = GetNode<Label>("Score");
		
		CustomSignals._Instance.StartLevel += StartLevel;
		_back.Pressed += Reset;
		CustomSignals._Instance.Reset += Reset;
		CustomSignals._Instance.ToggleMusic += ToggleMusic;

		AnimateButtons();
	}

	public void AnimateButtons()
	{
		foreach (Node button in Tools.GetChildren<Button>(this))
		{
			var currentPosition = ((Button)button).Position;
			var tween = CreateTween();
			tween.TweenProperty(button, "position", currentPosition + Vector2.Left*3, .5);
			tween.TweenProperty(button, "position", currentPosition + Vector2.Right*3, 1);
			tween.TweenProperty(button, "position", currentPosition, .5);
		}
		
		foreach (Node button in Tools.GetChildren<Card>(this))
		{
			var currentPosition = ((Card)button).Position;
			var tween = CreateTween();
			tween.TweenProperty(button, "position", currentPosition + Vector2.Left*20, .5);
			tween.TweenProperty(button, "position", currentPosition + Vector2.Right*20, 1);
			tween.TweenProperty(button, "position", currentPosition, .5);
		}

		CreateTween().TweenCallback(Callable.From(AnimateButtons)).SetDelay(2);
	}

	public void ToggleMusic(bool on)
	{
		var player = GetNode<AudioStreamPlayer2D>("AudioStreamPlayer2D");
		player.StreamPaused = !on;
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
