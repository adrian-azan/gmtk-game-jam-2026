using Godot;
using System;
using Godot.Collections;

public partial class CustomSignals : Node
{
	public static CustomSignals _Instance;

	public override void _Ready()
	{
		base._Ready();
		_Instance = this;
	}

	//SAMPLE
	//[Signal]
	//public delegate void LoadNotesEventHandler();


	[Signal]
	public delegate void StartLevelEventHandler(int level);
	
	[Signal]
	public delegate void CheckCardsEventHandler(Card selectedCard);

	[Signal]
	public delegate void LockCardsEventHandler(bool locked);
	
	[Signal]
	public delegate void ResetEventHandler();

}
