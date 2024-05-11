class_name WolfIdleAnimState

extends WolfBaseAnimState


func Physics_update(_delta):

	super(_delta)

	if not actor.velocity.is_zero_approx():
		transitioned.emit("WolfWalkAnimState")

	# if is_attacking:
		# transitioned.emit("AttackAnimState")


