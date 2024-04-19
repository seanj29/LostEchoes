class_name AnimState
extends State

@export var sprite: AnimatedSprite2D
@export var actor: PlayerChar
@onready var facing := actor.current_direction


func Enter():
	play_anim()
	if not actor.direction_changed.is_connected(change_direction):
		actor.direction_changed.connect(change_direction)


## Plays the relevant animation based on the current direction of the Sprite
func play_anim():
	pass
	
func change_direction(dir: Type.Direction):
	facing = dir