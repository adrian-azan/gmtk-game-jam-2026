class_name EndOfDayReport
extends Node2D

func _ready():
	$Button.button_down.connect(Close)


func Close():
	CustomSignals.OpenShop.emit()

func Show(time: float = .5):
	create_tween().tween_property(self, "modulate", Color(1,1,1,1), time)
	$Button.disabled = false


func Hide(time: float = .2):
	create_tween().tween_property(self, "modulate", Color(1,1,1,0), time)
	$Button.disabled = true


func UpdateText():
	$RichTextLabel.text = "Mistakes Made: %d" % [OutputChecker.mistakes]
	$Mistakes.text = "Cash Earned\n %d" % [ 5 - OutputChecker.mistakes ]
