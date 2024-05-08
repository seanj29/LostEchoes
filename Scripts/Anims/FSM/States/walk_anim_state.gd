class_name WalkAnimState
extends PawnAnimState


func Physics_update(_delta):

	super(_delta)

	if actor.velocity.is_zero_approx():
		transitioned.emit("IdleAnimState")

	if is_attacking:
		transitioned.emit("AttackAnimState")
	
