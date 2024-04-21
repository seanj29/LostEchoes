class_name WalkAnimState
extends AnimState


func Physics_update(_delta):
	super(_delta)
	if actor.velocity.is_zero_approx():
		transitioned.emit("IdleAnimState")
	else:
		play_anim()

	if is_attacking:
		transitioned.emit("AttackAnimState")
	
