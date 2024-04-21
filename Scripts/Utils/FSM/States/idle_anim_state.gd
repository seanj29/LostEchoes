class_name IdleAnimState
extends AnimState


func Physics_update(_delta):
	
	super(_delta)

	if not actor.velocity.is_zero_approx():
		transitioned.emit("WalkAnimState")

	if is_attacking:
		transitioned.emit("AttackAnimState")




