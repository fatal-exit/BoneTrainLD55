extends Area2D

enum DIRECTIONS{NORTH,SOUTH,EAST,WEST}
var direction:int
var target_direction:int
var last_direction:int
var grid_size = 16
var length = 0
var positions = []
var directions = []
var last_position:Vector2
var children = []
var negative_count = 0

var skeleton_follower:PackedScene = preload("res://Scenes/skeletonfollower.tscn")

@onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var starting_direction = [0,1,2,3]
	direction = starting_direction.pick_random()
	choose_anim()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var up = Input.is_action_just_pressed("Up")
	var down = Input.is_action_just_pressed("Down")
	var left = Input.is_action_just_pressed("Left")
	var right = Input.is_action_just_pressed("Right")

	if up:
		if length==0 or direction != DIRECTIONS.SOUTH:
			target_direction=DIRECTIONS.NORTH
	if down:
		if length==0 or direction != DIRECTIONS.NORTH:
			target_direction=DIRECTIONS.SOUTH
	if left:
		if length==0 or direction != DIRECTIONS.EAST:
			target_direction=DIRECTIONS.WEST
	if right:
		if length==0 or direction != DIRECTIONS.WEST:
			target_direction=DIRECTIONS.EAST
			
	#if Input.is_action_just_pressed("debugSpawn"):
	


func _on_move_timer_timeout():
	directions.append(direction)
	positions.append(position)
	direction=target_direction
	choose_anim()
	match direction:
		DIRECTIONS.NORTH:
			position.y-=grid_size
		DIRECTIONS.SOUTH:
			position.y+=grid_size
		DIRECTIONS.EAST:
			position.x+=grid_size
		DIRECTIONS.WEST:
			position.x-=grid_size
			
	if len(children)!=0:
		for child in children:
			child.update(directions,positions)

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
	
	
func spawn_skelly():
	negative_count-=1
	var instance = skeleton_follower.instantiate()
	instance.number=negative_count
	instance.position=Vector2(-1000,-1000)
	children.append(instance)
	add_child(instance)
