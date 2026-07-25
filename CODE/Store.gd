@tool
class_name Store
extends Node2D

var queueAmount: int
var contractorAmount: int
var tokenAmount: int
var sabatogeAmount: int
var money: int

func _ready() -> void:
	if Engine.is_editor_hint():
		self_modulate = Color(1,1,1,1)

	queueAmount = 4
	contractorAmount = 10
	tokenAmount = 3
	sabatogeAmount = 2
	money = 0

	$GridContainer/Queue.button_down.connect(PurchaseBiggerQueue)
	$GridContainer/Processing.button_down.connect(PurchaseFasterProcessing)
	$GridContainer/Fiver.button_down.connect(PurchaseContractor)
	$GridContainer/Sabatoge.button_down.connect(PurchaseSabatogeCoworker)
	$CheckEmail.button_down.connect(CheckEmail)
	
	HideStore()
	

func _process(delta: float) -> void:
	pass
	
func PopulateCoins():
	var coins = $Coins as Node2D
	
	for  coin in coins.get_children():
		coin.queue_free()
		
	var y = 0
	var x = 0
	for i in range(money):
		var coin: Sprite2D = Sprite2D.new()
		coins.add_child(coin)
		coin.texture = ResourceLoader.load("res://ART/Assets/money.png")
		coin.position.x = x * 320
		coin.position.y = y * 320
		
		x += 1
		if x % 5 == 0:
			y += 1
			x = 0
			
			
	
func CheckEmail():
	CustomSignals.CheckEmail.emit()

func ShowStore() -> void:
	$GridContainer/Queue.disabled = false
	$GridContainer/Processing.disabled = false
	$GridContainer/Fiver.disabled = false
	$GridContainer/Sabatoge.disabled = false
	$CheckEmail.disabled = false
	PopulateCoins()
	create_tween().tween_property(self, "modulate", Color(1,1,1,1), .8)
	
func HideStore() -> void:
	$GridContainer/Queue.disabled = true
	$GridContainer/Processing.disabled = true
	$GridContainer/Fiver.disabled = true
	$GridContainer/Sabatoge.disabled = true
	$CheckEmail.disabled = true
	create_tween().tween_property(self, "modulate", Color(1,1,1,0), .1)

func EarnMoney(amount: int):
	money += amount
	if money > 25:
		money = 25

func PurchaseBiggerQueue():
	if queueAmount <= 0 or money < 3:
		return
	queueAmount -= 1
	money -= 3

	PopulateCoins()
	CustomSignals.PurchaseBiggerQueue.emit()
	
func PurchaseFasterProcessing():
	if tokenAmount <= 0 or money < 4:
		return
	tokenAmount -= 1
	money -= 4
	
	PopulateCoins()
	CustomSignals.PurchaseFasterProcessing.emit()

func PurchaseContractor():
	if contractorAmount <= 0 or money < 2:
		return
	contractorAmount -= 1
	money -= 2
	
	PopulateCoins()
	CustomSignals.PurchaseContractor.emit()
	
func PurchaseSabatogeCoworker():
	if sabatogeAmount <= 0 or money < 11:
		return
	sabatogeAmount -= 1
	money -= 11
	
	PopulateCoins()
	CustomSignals.PurchaseSabatogeCoworker.emit()
