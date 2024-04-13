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
var skelly_queued:bool

var skeleton_follower:PackedScene = preload("res://Scenes/skeletonfollower.tscn")

@onready var animation_player = $AnimationPlayer
@onready var marker_2d = $Sprite2D/Marker2D
@onready var sfx_player = $SFXPlayer
@onready var movement_player = $MovementPlayer
@onready var sfx_player_2 = $SFXPlayer2

@export var bone_collect_sfx: AudioStream
@export var skeleton_create_sfx: AudioStream



# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var starting_direction = [0,1,2,3]
	direction = starting_direction.pick_random()
	choose_anim()
	skelly_queued =false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var up = Input.is_action_just_pressed("Up")
	var down = Input.is_action_just_pressed("Down")
	var left = Input.is_action_just_pressed("Left")
	var right = Input.is_action_just_pressed("Right")
	
	length=len(children)

	if up:
		if length==0 or direction != DIRECTIONS.SOUTH:
			target_direction=DIRECTIONS.NORTH
			movement_player.play()
	if down:
		if length==0 or direction != DIRECTIONS.NORTH:
			target_direction=DIRECTIONS.SOUTH
			movement_player.play()
	if left:
		if length==0 or direction != DIRECTIONS.EAST:
			target_direction=DIRECTIONS.WEST
			movement_player.play()
	if right:
		if length==0 or direction != DIRECTIONS.WEST:
			target_direction=DIRECTIONS.EAST
			movement_player.play()
			

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
			
	if skelly_queued:
		play_sfx(skeleton_create_sfx)
		negative_count-=1
		var instance = skeleton_follower.instantiate()
		instance.z_index=0
		#instance.global_position=marker_2d.global_position
		instance.number=negative_count
		instance.spawning=true
		#instance.global_position=positions[instance.number]
		children.append(instance)
		add_child(instance)
		skelly_queued=false
		
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
	
func play_sfx(sfx:AudioStream):
	sfx_player.set_stream(sfx)
	sfx_player.play()
func play_collected():
	sfx_player_2.set_stream(bone_collect_sfx)
	sfx_player_2.play()
