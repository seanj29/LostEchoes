class_name AttackAnimState
extends PawnAnimState

var frame_count := 0


func Enter():
	super()
	if sprite.animation.begins_with(anim_name):
		if not sprite.animation_finished.is_connected(change):
			sprite.animation_finished.connect(change)
		if not sprite.frame_changed.is_connected(update_frame_count):
			sprite.frame_changed.connect(update_frame_count)
	else:
		if sprite.animation_finished.is_connected(change):
			sprite.animation_finished.disconnect(change)
		if sprite.frame_changed.is_connected(update_frame_count):
			sprite.frame_changed.connect(update_frame_count)


func change():
	transitioned.emit("IdleAnimState")


func update_frame_count():
	frame_count += 1
	if frame_count == 5:
		frame_count = 0
		change()
	print(frame_count)


func Exit():
		if sprite.animation_finished.is_connected(change):
			sprite.animation_finished.disconnect(change)
		if sprite.frame_changed.is_connected(update_frame_count):
			sprite.frame_changed.disconnect(update_frame_count)