class_name CharInput

extends CharacterBody2D


@onready var Level := get_node("/root/Level")
@export var SPEED = 250.0

@export var AttackTimer: Timer

@export var stats: StatSheet

## Emitted when the direction changes
signal direction_changed(direction: Type.Direction)

## Emitted when the pawn attacks
signal attack_pressed(who: PawnInput, pos: Vector2, dir: Type.Direction)

@onready var current_health = stats.max_health:
	get:
		return current_health
	set(value):
		if value > 0:
			current_health = value
		else:
			current_health = 0
			die()


var is_attacking: bool

## The current direction the sprite is facing. [br]
## if it it is given a default, then the Sprite will start in that direction.
var current_direction: Type.Direction


func _physics_process(_delta):
	is_attacking = attack_state()
	var direction := direction_state()
	if teleport_state() == true:
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

func teleport_self(_dir: Vector2 = Vector2.UP) -> void:
	return

func attack_rec(attacker: CharInput, attack_strength: int) -> void:
	current_health -= attack_strength
	print("Attacked for %s damage by %s, new health is %s" % [attack_strength, attacker, current_health])


func die():
	print("ahh I diiieedd")
	queue_free()