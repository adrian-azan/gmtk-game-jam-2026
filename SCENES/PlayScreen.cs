using Godot;
using System;
using System.Linq;
using Godot.Collections;

[Tool]
public partial class PlayScreen : Node2D
{
	private Array<RemoteTransform2D> _cardRemoteTransforms = new();
	private Array<Sprite2D> _cardSprites = new();
	
	private PackedScene _cardScene = ResourceLoader.Load<PackedScene>("res://SCENES/Card.tscn");

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
		SetScene();
	}

	public void SetScene()
	{
		foreach (var child in GetChildren())
		{
			child.QueueFree();
		}
		
		_cardRemoteTransforms.Clear();
		_cardSprites.Clear();
		
		
		for (int i = 0; i < _columns; i++)
		{
			for (int j = 0; j < _rows; j++)
			{
				var newCard = _cardScene.Instantiate<Node2D>();
				_cardSprites.Add(newCard.GetNode<Sprite2D>("Sprite2D"));
				AddChild(newCard);
				
				var remoteTransform = new RemoteTransform2D();
				AddChild(remoteTransform);
				remoteTransform.Position = new Vector2(i*(newCard.GetChild<Sprite2D>(0).Texture.GetSize().X + _columnBuffer), 
					j*(newCard.GetChild<Sprite2D>(0).Texture.GetSize().Y + _rowBuffer));
			

				remoteTransform.RemotePath = newCard.GetPath();
				
				_cardRemoteTransforms.Add(remoteTransform);
			}
		}
		
		SetCards();

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
		
		Array<Sprite2D> cardsToSet = new(_cardSprites);

		for (int i = 0; i < _cardSprites.Count / 2; i++)
		{
			var card1 = cardsToSet.PickRandom();
			Logging.PrintTemp(cardsToSet.Remove(card1).ToString());
			
			var card2 = cardsToSet.PickRandom();
			Logging.PrintTemp(cardsToSet.Remove(card2).ToString());

			
			var face = cardTextures.PickRandom();
			cardTextures.Remove(face);
			Logging.PrintTemp($"{face.LoadPath}");

			
			card1.Texture = face;
			card2.Texture = face;
		}
		
	}
	
}
