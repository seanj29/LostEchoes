class_name WolfBaseAnimState
extends PawnAnimState



func Enter():
	super()
	anim_name = anim_name.trim_prefix("Wolf")


## Plays the relevant animation based on the current direction of the Sprite
func play_anim():

	match facing:

		Type.Direction.N:
			sprite.play("%s_NE" % anim_name)
		Type.Direction.NE:
			sprite.play("%s_NE" % anim_name)
		Type.Direction.E:
			sprite.play("%s_SE" % anim_name)
		Type.Direction.SE:
			sprite.play("%s_SE" % anim_name)
		Type.Direction.W:
			sprite.play("%s_SW" % anim_name)
		Type.Direction.NW:
			sprite.play("%s_NW" % anim_name)
		Type.Direction.S: 
			sprite.play("%s_S" % anim_name)
		Type.Direction.SW:
			sprite.play("%s_SW" % anim_name)
		_: 
			print("How??")
	