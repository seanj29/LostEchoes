class_name AttackAnimState
extends AnimState

func Enter():
	if sprite.animation.begins_with("Attack"):
		if not sprite.animation_finished.is_connected(change):
			sprite.animation_finished.connect(change)
	else:
		if sprite.animation_finished.is_connected(change):
			sprite.animation_finished.disconnect(change)


func Physics_update(_delta):
	super(_delta)
	play_anim()
	actor.SPEED = 25
	
	

func play_anim():

	match facing:

		Type.Direction.N:
			sprite.play("Attack_N")
		Type.Direction.NE:
			sprite.play("Attack_NE")
		Type.Direction.E:
			sprite.play("Attack_E")
		Type.Direction.SE:
			sprite.play("Attack_SE")
		Type.Direction.W:
			sprite.play("Attack_W")
		Type.Direction.NW:
			sprite.play("Attack_NW")
		Type.Direction.S: 
			sprite.play("Attack_S")
		Type.Direction.SW:
			sprite.play("Attack_SW")
		_: 
			print("How??")

func Exit():
	actor.SPEED = 250

func change():
	transitioned.emit("IdleAnimState")