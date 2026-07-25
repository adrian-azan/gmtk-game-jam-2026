extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Button.button_down.connect(CloseEmail)
	$Button.disabled = true

func CloseEmail():
	CustomSignals.StartWorkDay.emit()
