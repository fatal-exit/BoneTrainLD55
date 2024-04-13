extends Area2D

var direction: Vector2
var speed:int = 100
@onready var animation_player = $AnimationPlayer
@onready var collision_shape_2d = $CollisionShape2D
var despawning:bool

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("default")
	despawning = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !despawning:
		position += speed*direction*delta
	
	

func _on_player_entered(area):
	if area.is_in_group("PlayerHead"):
		area.play_collected()
		despawning=true
		area.skelly_queued=true
		animation_player.play("despawn")
		GameManager._increment_score()
		collision_shape_2d.disabled=true
		var tween = get_tree().create_tween()
		await get_tree().create_timer(0.5).timeout
		queue_free()
	
