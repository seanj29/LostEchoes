extends AnimScript

## This script provides animation to the Ghosts within the scene.

## Called to decide which animation to played depending on whether the sprite is moving or not. [br]
## [param vec] needs to be a normalized Vetcor of length 1.
func play_anim(vec: Vector2):
	if vec:
		play_walk(vec)
	else:
		play_idle()