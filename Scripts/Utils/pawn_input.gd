class_name PawnInput

extends CharacterBody2D


@onready var Level := get_node("/root/Level")

@export var SPEED = 250.0
@export var TeleportUnits = 150

@export var AttackTimer: Timer
@export var TeleportTimer: Timer


## Emitted when the direction changes
signal direction_changed(direction: Type.Direction)

## Emitted when the pawn attacks
signal attack_pressed(who: PawnInput, pos: Vector2, dir: Type.Direction)

var is_attacking: bool
var is_teleport: bool
## The current direction the sprite is facing. [br]
## if it it is given a default, then the Sprite will start in that direction.
var current_direction: Type.Direction

var ReplayDict: Dictionary

func _physics_process(_delta):
	is_attacking = attack_state()
	is_teleport = teleport_state()
	var direction := direction_state()
	if is_teleport:
		teleport_self(direction)
	if direction:
		velocity = direction * SPEED
		calc_direction(direction)
	else:
		velocity = Vector2.ZERO


	move_and_slide()


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
	
func teleport_state() -> bool:
	return false

func teleport_self(dir: Vector2 = Vector2.UP) -> void:
	global_position += (dir * TeleportUnits)
