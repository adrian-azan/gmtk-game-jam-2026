extends Node2D


@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
@onready var shop = $Shop
@onready var email = $Email
@onready var handButton: HandButton = $HandButton
@onready var terminationTimer: TerminationTimer = $TerminationTimer
@onready var dayTimer: DayTimer = $Clock
@onready var endOfDayReport: EndOfDayReport = $EndOfDayReport



func _ready() -> void:

	$WorkMusic.play()
	shop.money = 0
	CustomSignals.EndDay.connect(EndOfDay)
	CustomSignals.CheckEmail.connect(CheckEmail)
	CustomSignals.StartWorkDay.connect(StartWorkDay)
	CustomSignals.OpenShop.connect(OpenShop)
	CustomSignals.MistakeMade.connect(MistakeMade)

func MistakeMade():
	var turnRed = create_tween()
	turnRed.tween_property($Player/Desk, "self_modulate",Color(1,.5,.5,1),.5)
	turnRed.tween_property($Player/Desk, "self_modulate",Color(1,1,1,1),.5)
	
	
		
func EndOfDay():
	terminationTimer.paused = true
	handButton.paused = true
	$WorkMusic.stream_paused = true
	$ShopMusic.play()
	animationPlayer.play("ToMonitor")
	endOfDayReport.Show()
	OutputChecker.dayCount += 1

	if OutputChecker.dayCount <= 5:	
		var content = JSON.parse_string(FileAccess.get_file_as_string("res://ART/EMAILS/Day%d.txt" % OutputChecker.dayCount))
		email.SetText(content["content"], content["subject"])
	else:
		email.SetText("...", ">:[")
		
	if handButton.fullReport.length() < 20:
		OutputChecker.mistakes = 5
			
	endOfDayReport.UpdateText()
	
	if 5 - OutputChecker.mistakes > 0:
		shop.EarnMoney(5-OutputChecker.mistakes)
	
	
func OpenShop():
	endOfDayReport.Hide()
	shop.Show()

func CheckEmail():
	shop.Hide()
	email.Show()
		
func StartWorkDay():
	$ShopMusic.stream_paused = true
	$WorkMusic.play()
	email.Hide()
	OutputChecker.mistakes = 0
	OutputChecker.patternCounter = 0
	
	terminationTimer.decayRate *= 1.1

	handButton.paused = false
	terminationTimer.paused = false
	
	handButton.Reset()
	dayTimer.Reset()
	animationPlayer.play_backwards("ToMonitor")
