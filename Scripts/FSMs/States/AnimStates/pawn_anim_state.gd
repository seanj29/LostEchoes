class_name PawnAnimState
extends AnimState


var is_attacking: bool

func Enter():
	if actor is PawnInput:
		super()
		if not actor.direction_changed.is_connected(change_direction):
			actor.direction_changed.connect(change_direction)
	else:
		push_warning("This Node requires a PawnInput class as it's Actor variable")

func Physics_update(_delta):
	super(_delta)
	is_attacking = actor.is_attacking


func change_direction(dir: Type.Direction):
	facing = dir