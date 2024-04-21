class_name AttackAnimState
extends AnimState


func Enter():
	super()
	if sprite.animation.begins_with("Attack"):
		if not sprite.animation_finished.is_connected(change):
			sprite.animation_finished.connect(change)
	else:
		if sprite.animation_finished.is_connected(change):
			sprite.animation_finished.disconnect(change)
	
	actor.SPEED = 100 
	

func Physics_update(_delta):
	super(_delta)
	play_anim()
	

func Exit():
	actor.SPEED = 250


func change():
	transitioned.emit("IdleAnimState")