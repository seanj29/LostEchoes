class_name AnimState
extends State

@onready var parent: AnimStateMachine = get_parent()
@onready var sprite: AnimatedSprite2D = parent.sprite
@onready var actor: PawnMovement = parent.actor
@onready var facing: Type.Direction = actor.current_direction
var animation_over 
var is_attacking: bool

func Enter():
	if not actor.direction_changed.is_connected(change_direction):
		actor.direction_changed.connect(change_direction)
	play_anim()

func Physics_update(_delta):
	is_attacking = actor.is_attacking

## Plays the relevant animation based on the current direction of the Sprite
func play_anim():
	pass
	
func change_direction(dir: Type.Direction):
	facing = dir
