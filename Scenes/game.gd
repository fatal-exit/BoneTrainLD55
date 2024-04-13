extends Node2D

#@onready var player_detector_grid = $PlayerDetectorGrid
#const  GRID_WIDTH:int= 18
#const  GRID_HEIGHT:int= 12
#const CELLSTARTOFFSET:int = 16
#const GRIDSQUARE:int = 16
@onready var bone_timer = $BoneTimer
@onready var player = $Player

var bone:PackedScene = preload("res://Scenes/bone.tscn")

var spawner_locations = [$BoneSpawner,$BoneSpawner2,$BoneSpawner3,$BoneSpawner4]
var left_spawns: Vector2
var right_spawns: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	#for cell_x in range(GRID_WIDTH):
		#for cell_y in range(GRID_HEIGHT):
			#print(Vector2((cell_x*GRIDSQUARE)+CELLSTARTOFFSET,(cell_y*GRIDSQUARE)+CELLSTARTOFFSET))
	pass

func _on_bone_timer_timeout():
	left_spawns= Vector2(-50,randf_range(50,150))
	right_spawns= Vector2(350,randf_range(50,150))
	var spawns = [left_spawns,right_spawns]
	var spawn_loc = spawns.pick_random()
	var instance = bone.instantiate()
	instance.set_position(spawn_loc)
	instance.direction=instance.position.direction_to(Vector2(player.position.x,player.position.y+randf_range(-50,50)))
	add_child(instance)
