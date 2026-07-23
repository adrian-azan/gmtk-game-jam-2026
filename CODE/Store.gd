@tool
extends Node2D


func _ready() -> void:
	$GridContainer/Queue.button_down.connect(PurchaseBiggerQueue)
	$GridContainer/Processing.button_down.connect(PurchaseFasterProcessing)

func _process(delta: float) -> void:
	pass
	
	
func PurchaseBiggerQueue():
	CustomSignals.PurchaseBiggerQueue.emit()
	
func PurchaseFasterProcessing():
	CustomSignals.PurchaseFasterProcessing.emit()
