class_name PawnMovement

extends CharacterBody2D


@onready var Level := get_node("/root/Level")

@export var SPEED = 250.0

var VectorNE := (Vector2.UP + Vector2.RIGHT).normalized()
var VectorNW := (Vector2.UP + Vector2.LEFT).normalized()
var VectorSE := (Vector2.DOWN + Vector2.RIGHT).normalized()
var VectorSW := (Vector2.DOWN + Vector2.LEFT).normalized()

## Emitted when the direction changes
signal direction_changed(direction: Type.Direction)

## Emitted when the pawn attacks
signal attack_pressed

var is_attacking: bool
## The current direction the sprite is facing. [br]
## if it it is given a default, then the Sprite will start in that direction.
var current_direction: Type.Direction

var ReplayDict: Dictionary


## This function calculates the direction, based on [param dir], which is usually called during the [method play_walk] function.
func calc_direction(dir: Vector2):

	match dir:
		
		Vector2.UP:
			current_direction = Type.Direction.N
		VectorNE:
			current_direction = Type.Direction.NE
		Vector2.RIGHT:
			current_direction = Type.Direction.E
		VectorSE:
			current_direction = Type.Direction.SE
		Vector2.LEFT:
			current_direction = Type.Direction.W
		VectorNW:
			current_direction = Type.Direction.NW
		Vector2.DOWN:
			current_direction = Type.Direction.S
		VectorSW:
			current_direction = Type.Direction.SW
	
	direction_changed.emit(current_direction)