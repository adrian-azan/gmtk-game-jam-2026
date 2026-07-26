class_name HandButton
extends Node2D

@onready var handSprite: AnimatedSprite2D = $AnimatedSprite2D
var inputQueue: String
var fullReport: String
var maxQueueSize: int
var processingSpeed: float
var passiveInput: int
@onready var processInputTimer: Timer = $Timer
@onready var buttonClick: AudioStreamPlayer2D = $AudioStreamPlayer2D

var paused

signal timeAdded


func _ready() -> void:
	paused = false
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
	if inputQueue.length() >= maxQueueSize or paused:
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
		
	if Input.is_action_just_pressed("Backspace"):
		if fullReport.length() != 0:
			fullReport = fullReport.erase(fullReport.length()-1,1)

	$Label.text = str(inputQueue)
	DrawDebug()
	
func Reset():
	inputQueue = ""
	fullReport = ""
	processInputTimer.start(processingSpeed)

	
func DrawDebug() -> void:
	if fullReport.length() >= 15:
		($Debug as Label).text = "%d\n%s" % [fullReport.length(), fullReport.substr(fullReport.length()-15,15)]
	else: 
		($Debug as Label).text = "%d\n%s\n%d" % [fullReport.length(), fullReport, OutputChecker.mistakes] 
	
func RemoveFromQueue() -> void:
	if paused:
		return

	if inputQueue.length() > 0:
		if OutputChecker.Check(fullReport + inputQueue[inputQueue.length()-1])[1] == 0:
			handSprite.play()
			buttonClick.play()
			
			fullReport += inputQueue[0]
			inputQueue = inputQueue.erase(0)
			timeAdded.emit(240)
		else:
			$AudioStreamPlayer2D2.play()
			inputQueue = ""
			CustomSignals.MistakeMade.emit()
			
		
	timeAdded.emit(passiveInput)


func PurchaseBiggerQueue() -> void:
	maxQueueSize += 5

func PurchaseFasterProcessing() -> void:
	if processingSpeed <= .15:
		return
	processingSpeed -= .1
	processInputTimer.start(processingSpeed)

func PurchaseContractor() -> void:
	passiveInput += 30
	
func PurchaseSabatogeCoworker() -> void:
	timeAdded.emit(28800/2)
