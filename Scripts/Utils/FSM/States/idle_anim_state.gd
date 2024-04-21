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


func play_anim():

	match facing:

		Type.Direction.N:
			sprite.play("Idle_N")
		Type.Direction.NE:
			sprite.play("Idle_NE")
		Type.Direction.E:
			sprite.play("Idle_E")
		Type.Direction.SE:
			sprite.play("Idle_SE")
		Type.Direction.W:
			sprite.play("Idle_W")
		Type.Direction.NW:
			sprite.play("Idle_NW")
		Type.Direction.S: 
			sprite.play("Idle_S")
		Type.Direction.SW:
			sprite.play("Idle_SW")
		_: 
			print("How??")



