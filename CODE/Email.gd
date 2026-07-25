@tool

extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.is_editor_hint():
		
		self_modulate = Color(1,1,1,1)
		$Sprite2D.self_modulate = Color(1,1,1,1)
		$AnimatedSprite2D.self_modulate = Color(1,1,1,1)


	$Button.button_down.connect(CloseEmail)
	$Button.disabled = true

func CloseEmail():
	CustomSignals.StartWorkDay.emit()
