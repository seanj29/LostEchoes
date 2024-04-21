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
	

func play_anim():
	
	match facing:

		Type.Direction.N:
			sprite.play("Walk_N")
		Type.Direction.NE:
			sprite.play("Walk_NE")
		Type.Direction.E:
			sprite.play("Walk_E")
		Type.Direction.SE:
			sprite.play("Walk_SE")
		Type.Direction.W:
			sprite.play("Walk_W")
		Type.Direction.NW:
			sprite.play("Walk_NW")
		Type.Direction.S: 
			sprite.play("Walk_S")
		Type.Direction.SW:
			sprite.play("Walk_SW")
		_: 
			print("How??")

