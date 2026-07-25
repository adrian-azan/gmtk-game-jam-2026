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

func _process(delta: float) -> void:
	
	if animationPlayer.is_playing():
		return
		
func EndOfDay():
	handButton.paused = true
	animationPlayer.play("ToStore")
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
