@icon("res://Assets/Icons/wolf-4-svgrepo-com.svg")
class_name WolfScript

extends CharInput


#  Add a possible timer so that the transition will always happen after a set amount of time.
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var home_pos := global_position

@onready var nav: NavigationAgent2D = $NavigationAgent2D


@export var ReachedRadius := 20
@export var RoamRadius := 100

var dir: Vector2

func _ready():

	sprite.play("Idle_NE")
	nav.target_desired_distance = ReachedRadius


func randomPoint() -> Vector2:

	var angle = randf_range(0, TAU)
	var randomRadius = randf_range(5, RoamRadius)

	var x = home_pos.x + randomRadius * cos(angle)
	var y = home_pos.y + randomRadius * sin(angle)

	return Vector2(x, y)

func direction_state() -> Vector2:
		direction_changed.emit(dir)
		return dir


	
