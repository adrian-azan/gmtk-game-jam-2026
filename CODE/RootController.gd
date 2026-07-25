extends Node2D


enum STATE {WORKING, STORE, EMAIL}

var state: STATE

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
@onready var store = $Store
@onready var email = $Email
@onready var handButton: HandButton = $HandButton

func _ready() -> void:
	state = STATE.WORKING
	
	CustomSignals.EndDay.connect(EndOfDay)
	CustomSignals.CheckEmail.connect(CheckEmail)
	CustomSignals.StartWorkDay.connect(StartWorkDay)

	($EndOfDayReport/Button as Button).button_down.connect(OpenStore)

func _process(delta: float) -> void:
	
	if animationPlayer.is_playing():
		return
		
func EndOfDay():
	handButton.paused = true
	animationPlayer.play("ToStore")
	create_tween().tween_property($EndOfDayReport, "modulate", Color(1,1,1,1), .8)
	print(handButton.fullReport)
	var formattedReport = OutputChecker.Level2(handButton.fullReport)
	$EndOfDayReport/RichTextLabel.text = formattedReport[0]
	$EndOfDayReport/Mistakes.text = "Cash Earned\n %d" % [ 5 - formattedReport[1]]
	store.EarnMoney(5-formattedReport[1])
	$EndOfDayReport/Button.disabled = false
	

	
func OpenStore():
	$EndOfDayReport/Button.disabled = true
	create_tween().tween_property($EndOfDayReport, "modulate", Color(1,1,1,0), .25)
	store.ShowStore()
	state = STATE.STORE

func CheckEmail():
	store.HideStore()
	(email.get_node("AnimationPlayer") as AnimationPlayer).play("ShowEmail")
	
func StartWorkDay():
	(email.get_node("AnimationPlayer") as AnimationPlayer).play("HideEmail")

	handButton.paused = false
	handButton.Reset()
	$TerminationTimer.paused = false
	$Clock.Reset()
	animationPlayer.play_backwards("ToStore")
	store.HideStore()
	state = STATE.WORKING
