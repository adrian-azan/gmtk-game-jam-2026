using Godot;
using System;

public partial class MainScreen : Node2D
{
	private Button _levelSelect;
	private Button _exit;
	private Button _musicToggle;
	
	
	public override void _Ready()
	{
		_levelSelect = GetNode<Button>("Level Select");
		_exit = GetNode<Button>("Exit");
		_musicToggle = GetNode<Button>("CheckButton");
		foreach (Button child in _levelSelect.GetChildren())
		{
			child.Scale = Vector2.Zero;
		}


		_musicToggle.Toggled += on =>
		{
			CustomSignals._Instance.EmitSignal(CustomSignals.SignalName.ToggleMusic, on);
		};
		_exit.Pressed += () => { GetTree().Quit(); };
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
}
