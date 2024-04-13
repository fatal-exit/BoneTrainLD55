extends Area2D

enum DIRECTIONS{NORTH,SOUTH,EAST,WEST}
var number: int
@onready var animation_player = $AnimationPlayer
var direction: int


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func update(directions,positions):
	global_position=positions[number]
	direction=directions[number]
	choose_anim()
	
func choose_anim():
	match direction:
		DIRECTIONS.NORTH:
			animation_player.play("Up")
		DIRECTIONS.SOUTH:
			animation_player.play("Down")
		DIRECTIONS.EAST:
			animation_player.play("Right")
		DIRECTIONS.WEST:
			animation_player.play("Left")
