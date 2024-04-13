extends Area2D

var direction: Vector2
var speed:int = 100
@onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += speed*direction*delta
	animation_player.play("default")

func _on_player_entered(area):
	if area.is_in_group("PlayerHead"):
		area.spawn_skelly()
		queue_free()
	
