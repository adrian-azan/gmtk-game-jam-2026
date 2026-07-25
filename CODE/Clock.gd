class_name Clock
extends Node2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
var frameProgressionTimer: Timer
var endOfDayCount: int = 62

func _ready() -> void:
	frameProgressionTimer = Timer.new()
	add_child(frameProgressionTimer)
	frameProgressionTimer.timeout.connect(ProgressFrame)
	frameProgressionTimer.start(1.875)

func ProgressFrame():
	sprite.frame += 1
	endOfDayCount += 1
	
	if endOfDayCount == 64:
		CustomSignals.EndDay.emit()

func Reset():
	frameProgressionTimer.start(1.875)
	endOfDayCount = 62
	sprite.frame = 0
