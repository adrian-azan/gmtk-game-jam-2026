class_name HandButton
extends Node2D

@onready var handSprite: AnimatedSprite2D = $AnimatedSprite2D
var inputQueue: String
var maxQueueSize: int
var processingSpeed: float
var passiveInput: int
@onready var processInputTimer: Timer = $Timer

signal timeAdded


func _ready() -> void:
	inputQueue = ""
	maxQueueSize = 5
	processingSpeed = .5
	processInputTimer.timeout.connect(RemoveFromQueue)
	processInputTimer.one_shot = false
	processInputTimer.start(processingSpeed)
	
	CustomSignals.PurchaseBiggerQueue.connect(PurchaseBiggerQueue)
	CustomSignals.PurchaseFasterProcessing.connect(PurchaseFasterProcessing)
	CustomSignals.PurchaseContractor.connect(PurchaseContractor)
	CustomSignals.PurchaseSabatogeCoworker.connect(PurchaseSabatogeCoworker)


func _process(delta: float) -> void:
	if inputQueue.length() >= maxQueueSize:
		return
	
	if Input.is_action_just_pressed("DoWork_1"):
		inputQueue += "K"
	if Input.is_action_just_pressed("DoWork_2"):
		inputQueue += "J"
	if Input.is_action_just_pressed("DoWork_3"):
		inputQueue += "I"
	if Input.is_action_just_pressed("DoWork_4"):
		inputQueue += "L"
	
	if Input.is_action_just_pressed("DoWork_5"):
		inputQueue += "S"
	if Input.is_action_just_pressed("DoWork_6"):
		inputQueue += "A"
	if Input.is_action_just_pressed("DoWork_7"):
		inputQueue += "W"
	if Input.is_action_just_pressed("DoWork_8"):
		inputQueue += "D"	

	$Label.text = str(inputQueue)
	DrawDebug()
	
	
func DrawDebug() -> void:
	($Debug as Label).text = "%s\n%f\n%d" % [maxQueueSize, processingSpeed,passiveInput] 
	
func RemoveFromQueue() -> void:
	if inputQueue.length() > 0:
		handSprite.play()
		inputQueue = inputQueue.erase(0)
		timeAdded.emit(120)
		
	timeAdded.emit(passiveInput)


func PurchaseBiggerQueue() -> void:
	maxQueueSize += 5

func PurchaseFasterProcessing() -> void:
	if processingSpeed <= .15:
		return
	processingSpeed -= .1
	processInputTimer.start(processingSpeed)

func PurchaseContractor() -> void:
	passiveInput += 5
	
func PurchaseSabatogeCoworker() -> void:
	timeAdded.emit(28800/2)
