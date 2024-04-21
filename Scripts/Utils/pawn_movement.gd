class_name PawnMovement

extends CharacterBody2D


@onready var Level := get_node("/root/Level")

@export var ice_shot_scene: PackedScene 
@export var SPEED = 250.0

## Emitted when the direction changes
signal direction_changed(direction: Type.Direction)

## Emitted when the pawn attacks
signal attack_pressed

var is_attacking: bool
## The current direction the sprite is facing. [br]
## if it it is given a default, then the Sprite will start in that direction.
var current_direction: Type.Direction

var ReplayDict: Dictionary

func _physics_process(_delta):
	is_attacking = attack_state()
	var direction := direction_state()
	if direction:
		velocity = direction * SPEED
		calc_direction(direction)
	else:
		velocity = Vector2.ZERO


	move_and_slide()

func _init():
	print()

## This function calculates the direction, based on [param dir], which is usually called during the [method play_walk] function.
func calc_direction(dir: Vector2):
	
	current_direction = Type.convertVectorToDirection(dir)
	direction_changed.emit(current_direction)


## Ovverridable fuction to calc the [member direction] variable of the pawn class. Should be Normalized Vector of length 1
func direction_state() -> Vector2:
	return Vector2.ZERO


## Ovverridable fuction to change the [member is_attacking] variable of the pawn class.
func attack_state() -> bool:
	return false
	