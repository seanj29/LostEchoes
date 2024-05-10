@icon("res://Assets/Icons/wolf-4-svgrepo-com.svg")
class_name WolfScript

extends CharInput


#  Add a possible timer so that the transition will always happen after a set amount of time.
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var home_pos := global_position

@onready var nav: NavigationAgent2D = $NavigationAgent2D

var target_pos: Vector2

var target_reached := false

var dir: Vector2

@export var ReachedRadius := 10
@export var RoamRadius := 100

func _ready():
	sprite.play("Idle_NE")
	target_pos = randomPoint()
	dir = calc_roaming_vector()

func _physics_process(_delta):
	super(_delta)
	var distanceTo = global_position.distance_squared_to(target_pos)
	nav.target_position = target_pos
	nav.get_next_path_position()

	if distanceTo < ReachedRadius:
		target_reached = true
		# TODO Make this into a state machine and emit the "Idle" State here
		print("reached!")
		dir = Vector2.ZERO


func randomPoint():

	var angle = randf_range(0, TAU)
	var randomRadius = randf_range(30, RoamRadius)

	var x = home_pos.x + randomRadius * cos(angle)
	var y = home_pos.y + randomRadius * sin(angle)

	return Vector2(x, y)

func direction_state() -> Vector2:
	return dir

func calc_roaming_vector() -> Vector2:
	var dirVector = global_position.direction_to(target_pos)
	return dirVector
	
# func calc_direction_vector(StateDict: Dictionary) -> Vector2:
# 	var current_direction_vector = Vector2(0, 0)
# 	if StateDict.Up_pressed:
# 		current_direction_vector.y -= 1
# 	if StateDict.Down_pressed:
# 		current_direction_vector.y += 1
# 	if StateDict.Left_pressed:
# 		current_direction_vector.x -= 1
# 	if StateDict.Right_pressed:
# 		current_direction_vector.x += 1
	
# 	return current_direction_vector.normalized()