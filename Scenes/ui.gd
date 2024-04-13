extends Control

var starting:bool = false
var game_over:bool
@onready var context_label = $MarginContainer/ContextLabel
@onready var score_label = $MarginContainer/HBoxContainer/ScoreLabel
@onready var sfx_player = $SFXPlayer
@onready var final_score = $MarginContainer/MarginContainer/FinalScore

@export var loss_sfx: AudioStream
@export var blip_sfx: AudioStream

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode=Node.PROCESS_MODE_ALWAYS
	final_score.hide()
	GameManager._pause_game(true)
	context_label.show()
	context_label.text="Bone Train\nPress Space to Play!"
	GameManager.on_game_over.connect(on_game_over)
	GameManager.increment_score.connect(increment_score)
	
	score_label.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	game_over=GameManager.is_game_over
	if !starting and !game_over:
		if Input.is_action_just_pressed("Accept"):
			play_sfx(blip_sfx)
			context_label.text="Ready..."
			starting=true
			await get_tree().create_timer(1.2).timeout
			GameManager._pause_game(false)
			context_label.hide()
			score_label.show()

func on_game_over():
	play_sfx(loss_sfx)
	context_label.show()
	final_score.show()
	score_label.hide()
	context_label.text="Game Over!\nPress Space to Retry!"
	final_score.text="YOU SCORED:"+str(GameManager.score).pad_zeros(2)
	
func increment_score():
	score_label.text="Bones:"+str(GameManager.score).pad_zeros(2)

func play_sfx(sfx:AudioStream):
	sfx_player.set_stream(sfx)
	sfx_player.play()
