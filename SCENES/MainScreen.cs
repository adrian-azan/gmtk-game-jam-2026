using Godot;
using System;

public partial class MainScreen : Node2D
{
	private Button _start;
	private Button _levelSelect;
	private Button _exit;
	
	
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		_start = GetNode<Button>("Start");
		_levelSelect = GetNode<Button>("Level Select");
		_exit = GetNode<Button>("Exit");
		
		_start.Pressed += () => {CustomSignals._Instance.EmitSignal(CustomSignals.SignalName.StartLevel, 0);};
		
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}
}
