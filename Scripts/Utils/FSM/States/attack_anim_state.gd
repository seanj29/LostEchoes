class_name AttackAnimState
extends PawnAnimState


func Enter():
	super()
	if sprite.animation.begins_with(anim_name):
		if not sprite.animation_finished.is_connected(change):
			sprite.animation_finished.connect(change)
	else:
		if sprite.animation_finished.is_connected(change):
			sprite.animation_finished.disconnect(change)
	

func change():
	transitioned.emit("IdleAnimState")