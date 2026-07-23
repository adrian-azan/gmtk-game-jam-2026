extends Node2D

@onready var handSprite: AnimatedSprite2D = $AnimatedSprite2D

#func _ready() -> void:
	#handSprite.speed_scale = 30


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("DoWork"):
		handSprite.play()
