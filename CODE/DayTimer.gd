class_name DayTimer
extends Node2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
var frameProgressionTimer: Timer
var endOfDayCount: int = 0

func _ready() -> void:
	frameProgressionTimer = Timer.new()
	add_child(frameProgressionTimer)
	frameProgressionTimer.timeout.connect(ProgressFrame)
	frameProgressionTimer.start(1.875/2)

func _process(delta: float):
	if Input.is_action_just_pressed("Cheat"):
		endOfDayCount = 62


func ProgressFrame():
	sprite.frame += 1
	endOfDayCount += 1
	
	if endOfDayCount == 64:
		CustomSignals.EndDay.emit()

func Reset():
	frameProgressionTimer.start(1.875/2)
	endOfDayCount = 0
	sprite.frame = 0
