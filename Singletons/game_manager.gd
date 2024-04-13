extends Node


var is_game_over:bool
var score:int

signal on_game_over
signal increment_score

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode=Node.PROCESS_MODE_ALWAYS
	is_game_over= false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_game_over:
		if Input.is_action_just_pressed("Accept"):
			is_game_over=false
			await get_tree().create_timer(0.3).timeout
			score = 0
			get_tree().reload_current_scene()
	
func _game_over():
	on_game_over.emit()
	_pause_game(true)
	is_game_over=true

func _pause_game(paused:bool):
	get_tree().paused = paused
	
func _increment_score():
	score += 1
	increment_score.emit()
	
