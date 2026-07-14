using Godot;
using System;

public partial class MainScreen : Node2D
{
	private Button _start;
	private Button _levelSelect;
	private Button _exit;
	
	
	public override void _Ready()
	{
		_start = GetNode<Button>("Start");
		_levelSelect = GetNode<Button>("Level Select");
		_exit = GetNode<Button>("Exit");
		
		_start.Pressed += () => {CustomSignals._Instance.EmitSignal(CustomSignals.SignalName.StartLevel, 0);};
		_levelSelect.Pressed += () =>
		{
			if (_levelSelect.GetChild<Button>(1).Scale != Vector2.One)
			{
				foreach (Button child in _levelSelect.GetChildren())
				{
					CreateTween().TweenProperty(child, "scale", Vector2.One, .2f);
				}

			}
			else
			{
				foreach (Button child in _levelSelect.GetChildren())
				{
					CreateTween().TweenProperty(child, "scale", Vector2.Zero, .2f);
				}
			}
		};
		
		foreach (Button child in _levelSelect.GetChildren())
		{
			child.Pressed += () =>
			{
				CustomSignals._Instance.EmitSignal(CustomSignals.SignalName.StartLevel, Int32.Parse(child.Text) - 1);
			};
		}
	}

	public override void _Process(double delta)
	{
	}
}
