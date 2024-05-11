class_name WolfWalkAnimState

extends WolfBaseAnimState

func Physics_update(_delta):

	super(_delta)

	if actor.velocity.is_zero_approx():
		transitioned.emit("WolfIdleAnimState")
	# if is_attacking:
	# 	transitioned.emit("AttackAnimState")

