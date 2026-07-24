@tool
extends Node2D

var queueAmount: int
var contractorAmount: int
var tokenAmount: int
var sabatogeAmount: int

func _ready() -> void:
	queueAmount = 4
	contractorAmount = 10
	tokenAmount = 3
	sabatogeAmount = 2


	$GridContainer/Queue.button_down.connect(PurchaseBiggerQueue)
	$GridContainer/Processing.button_down.connect(PurchaseFasterProcessing)
	$GridContainer/Fiver.button_down.connect(PurchaseContractor)
	$GridContainer/Sabatoge.button_down.connect(PurchaseSabatogeCoworker)
	
	

func _process(delta: float) -> void:
	pass
	
	
func PurchaseBiggerQueue():
	if queueAmount <= 0:
		return
	queueAmount -= 1

	CustomSignals.PurchaseBiggerQueue.emit()
	
func PurchaseFasterProcessing():
	if tokenAmount <= 0:
		return
	tokenAmount -= 1
	
	CustomSignals.PurchaseFasterProcessing.emit()

func PurchaseContractor():
	if contractorAmount <= 0:
		return
	contractorAmount -= 1
	
	CustomSignals.PurchaseContractor.emit()
	
func PurchaseSabatogeCoworker():
	if sabatogeAmount <= 0:
		return
	sabatogeAmount -= 1
		
	CustomSignals.PurchaseSabatogeCoworker.emit()
