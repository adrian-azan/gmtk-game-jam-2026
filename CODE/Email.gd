extends Node2D

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	$Button.button_down.connect(CloseEmail)
	$Sprite2D/EmailContent.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$Button.disabled = true

func SetText(content: String):
	$Sprite2D/EmailContent.text = content

func CloseEmail():
	CustomSignals.StartWorkDay.emit()

func Hide():
	animationPlayer.play("HideEmail")
	$Sprite2D/EmailContent.mouse_filter = Control.MOUSE_FILTER_IGNORE


func Show():
	animationPlayer.play("ShowEmail")
	$Sprite2D/EmailContent.mouse_filter = Control.MOUSE_FILTER_STOP
