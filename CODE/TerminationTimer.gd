class_name TerminationTimer
extends Node2D

var time: int
var decayRate: int
@onready var timerLabel:RichTextLabel = $RichTextLabel

@export var totalTimeSeconds: int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time = 28800
	decayRate = time / totalTimeSeconds
	
	var hand = get_node("../HandButton") as HandButton
	if hand != null:
		hand.timeAdded.connect(AddTime)
	

func _process(delta: float) -> void:
	var times = CalculateTime()
	
	if time > 0:
		timerLabel.text = "%02d:%02d:%02d" % [times["hour"], times["minute"], times["second"]]
	else:
		timerLabel.text = "00:00:00"

	time -= decayRate * delta
	

func AddTime(amountInSeconds: int) -> void:
	time += amountInSeconds 

func CalculateTime() -> Dictionary:
	var times = {}
	var remainingTime = time
	 
	times["hour"] = remainingTime / 3600
	remainingTime -= times["hour"] * 3600
	times["minute"] = remainingTime / 60
	remainingTime -= times["minute"] * 60
	times["second"] = remainingTime

	return times
