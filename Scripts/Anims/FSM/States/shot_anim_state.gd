class_name ShotAnimState
extends AnimState


func Enter():
	super()
	if not actor.direction_changed.is_connected(change_direction):
		actor.direction_changed.connect(change_direction)


func change_direction(dir: Type.Direction):
	facing = dir