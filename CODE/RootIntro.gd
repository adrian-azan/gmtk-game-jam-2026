extends Node2D


@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
@onready var email = $Email



func _ready() -> void:

	$WorkMusic.play()
	animationPlayer.play("Intro")
	
	var content = ResourceLoader.load("res://ART/EMAILS/Day0J.tres", "JSON") as JSON
	email.SetText(content.data["content"], content.data["subject"])

	(email.get_node("Button") as Button).button_down.connect(StartGame)	

func CheckEmail():
	$EmailSound.play()
	email.Show()
	
	
func ZoomScreen():
	animationPlayer.play("ToMonitor")
	
func StartGame():
	var mainGame = (ResourceLoader.load("res://SCENES/Root.tscn", "PackedScene") as PackedScene).instantiate()
	get_tree().root.add_child(mainGame)
	queue_free()
	
