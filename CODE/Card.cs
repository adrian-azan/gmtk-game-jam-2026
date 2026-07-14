using Godot;
using System;

[Tool]
public partial class Card : Node2D
{
	public Sprite2D _back;
	public Sprite2D _face;
	
	private bool _locked;
	
	public int key;
	public override void _Ready()
	{
		_back = GetNode<Sprite2D>("Sprite2D2");
		_face = GetNode<Sprite2D>("Sprite2D");
		_locked = false;
		GetNode<Button>("Button").Pressed += () =>
		{
			ShowCard();
			CustomSignals._Instance.EmitSignal(CustomSignals.SignalName.CheckCards, this);
		};
		
		CustomSignals._Instance.LockCards += locked =>
		{
			_locked = locked;
		};
	}

	public void ShowCard()
	{
		if (_locked)
			return;
		CreateTween().TweenProperty(this, "rotation", 2*Math.PI, .5);
		CreateTween().TweenProperty(_back, "self_modulate",new Color(1,1,1,0), .5).SetDelay(.25f);
	}

	public void HideCard()
	{
		if (_locked)
			return;
		CreateTween().TweenProperty(this, "rotation", -2*Math.PI, .5);
		CreateTween().TweenProperty(_back, "self_modulate",new Color(1,1,1,1), .5).SetDelay(.25f);
	}

	public override void _Process(double delta)
	{
		GetNode<Label>("Label").Text = $"{key}";
	}
}
