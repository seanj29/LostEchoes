class_name IdleAnimState
extends AnimState


func Physics_update(_delta):
	super(_delta)
	if actor.velocity.is_zero_approx():
		play_anim()
	else:
		transitioned.emit("WalkAnimState")

	if is_attacking:
		transitioned.emit("AttackAnimState")




