extends Node2D


enum STATE {WORKING, STORE}

var state: STATE

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
@onready var store = $Store

func _ready() -> void:
	state = STATE.WORKING

func _process(delta: float) -> void:
	
	if animationPlayer.is_playing():
		return
		
	if Input.is_action_just_pressed("GoToDesktop"):
		if state == STATE.WORKING:
			animationPlayer.play("ToStore")
			store.ShowStore()
			state = STATE.STORE
			
			
		elif state == STATE.STORE:
			animationPlayer.play_backwards("ToStore")
			store.HideStore()
			state = STATE.WORKING
