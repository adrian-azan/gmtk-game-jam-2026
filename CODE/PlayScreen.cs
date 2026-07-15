using Godot;
using System;
using System.Linq;
using Godot.Collections;

[Tool]
public partial class PlayScreen : Node2D
{
	private Array<RemoteTransform2D> _cardRemoteTransforms = new();
	private Array<Card> _cards = new();
	
	private Card _firstSelectedCard;
	private Card _secondSelectedCard;
	
	private PackedScene _cardScene = ResourceLoader.Load<PackedScene>("res://SCENES/Card.tscn");

	public Tween _inAnimation;
	
	[ExportToolButton("Set Scene")]
	public Callable SetSceneButton => Callable.From(SetScene);
	
	[Export]
	public int _rows;
	[Export]
	public int _columns;

	[Export]
	private int _rowBuffer;
	[Export]
	private int _columnBuffer;
	
	public override void _Ready()
	{
		_firstSelectedCard = null;
		_secondSelectedCard = null;
		
		SetScene();
		
		CustomSignals._Instance.CheckCards += CheckCards;
	}


	public void SetScene()
	{
		foreach (Node2D child in GetNode("Cards").GetChildren())
		{
			child.QueueFree();
		}
		
		_cardRemoteTransforms.Clear();
		_cards.Clear();
		_firstSelectedCard = null;
		_secondSelectedCard = null;
		Globals.SCORE = 0;
		
		for (int i = 0; i < _columns; i++)
		{
			for (int j = 0; j < _rows; j++)
			{
				Card newCard = _cardScene.Instantiate<Card>();
				_cards.Add(newCard);
				GetNode("Cards").AddChild(newCard);
				
				
				var remoteTransform = new RemoteTransform2D();
				GetNode("Cards").AddChild(remoteTransform);
				remoteTransform.Position = new Vector2(i*(newCard.GetChild<Sprite2D>(0).Texture.GetSize().X + _columnBuffer), 
					j*(newCard.GetChild<Sprite2D>(0).Texture.GetSize().Y + _rowBuffer));
			

				remoteTransform.RemotePath = newCard.GetPath();
				
				_cardRemoteTransforms.Add(remoteTransform);
			}
		}
		
		SetCards();
	}

	public void CheckCards(Card selectedCard)
	{
		if (_firstSelectedCard == selectedCard || Visible == false)
			return;
		
		if (_firstSelectedCard == null)
		{
			_firstSelectedCard = selectedCard;
		}
		else if (_secondSelectedCard == null)
		{
			CustomSignals._Instance.EmitSignal(CustomSignals.SignalName.LockCards, true);
			Globals.SCORE += 1;
			
			_secondSelectedCard = selectedCard;

			if (_firstSelectedCard != null && _firstSelectedCard.key == _secondSelectedCard.key)
			{
				_inAnimation = CreateTween();
				_inAnimation.TweenCallback(Callable.From(() =>
				{
					_firstSelectedCard.QueueFree();
					_secondSelectedCard.QueueFree();
					
					_firstSelectedCard = null;
					_secondSelectedCard = null;
					
					if (GetNode("Cards").GetChildren().Where(n => n is Card).Count() == 2)
					{
						CustomSignals._Instance.EmitSignal(CustomSignals.SignalName.Reset);
					}
				})).SetDelay(1);
			}
			else
			{
				_inAnimation = CreateTween();
				_inAnimation.TweenCallback(Callable.From(() =>
				{
					_firstSelectedCard.HideCard();
					_secondSelectedCard.HideCard();
					
					_firstSelectedCard = null;
					_secondSelectedCard = null;
					
				})).SetDelay(1);
			}
			
			CreateTween()
				.TweenCallback(Callable.From(() =>
					CustomSignals._Instance.EmitSignal(CustomSignals.SignalName.LockCards, false))
					).SetDelay(1);

		}


	}


	public void SetCards()
	{
		Array<CompressedTexture2D> cardTextures = new();
		
		foreach (var suit in ResourceLoader.ListDirectory("res://ART/Card-Designs/png files/Card Faces/"))
		{
			foreach (var card in ResourceLoader.ListDirectory($"res://ART/Card-Designs/png files/Card Faces/{suit}") )
			{
				cardTextures.Add(ResourceLoader.Load<CompressedTexture2D>($"res://ART/Card-Designs/png files/Card Faces/{suit}/{card}"));
			}
		}
		
		Array<Card> cardsToSet = new(_cards);


			
		for (int i = 0; i <= _cards.Count / 2 && cardsToSet.Count > 1; i++)
		{
			if (cardsToSet.Count == 0 || cardTextures.Count == 0)
				return;
			
			var card1 = cardsToSet.PickRandom();
			cardsToSet.Remove(card1);
			
			var card2 = cardsToSet.PickRandom();
			cardsToSet.Remove(card2);
			
			var face = cardTextures.PickRandom();
			cardTextures.Remove(face);
			
			card1._face.Texture = face;
			card2._face.Texture = face;

			card1.key = i;
			card2.key = i;
		}
	}
}
