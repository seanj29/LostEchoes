class_name AnimState
extends State

@onready var parent: AnimStateMachine = get_parent()
@onready var sprite: AnimatedSprite2D = parent.sprite
@onready var actor: PawnMovement = parent.actor
@onready var facing: Type.Direction = actor.current_direction
@onready var anim_name = name.trim_suffix("AnimState")

var is_attacking: bool


func Enter():

	if not actor.direction_changed.is_connected(change_direction):
		actor.direction_changed.connect(change_direction)
	play_anim()


func Physics_update(_delta):
	is_attacking = actor.is_attacking


## Plays the relevant animation based on the current direction of the Sprite
func play_anim():

	match facing:

		Type.Direction.N:
			sprite.play("%s_N" % anim_name)
		Type.Direction.NE:
			sprite.play("%s_NE" % anim_name)
		Type.Direction.E:
			sprite.play("%s_E" % anim_name)
		Type.Direction.SE:
			sprite.play("%s_SE" % anim_name)
		Type.Direction.W:
			sprite.play("%s_W" % anim_name)
		Type.Direction.NW:
			sprite.play("%s_NW" % anim_name)
		Type.Direction.S: 
			sprite.play("%s_S" % anim_name)
		Type.Direction.SW:
			sprite.play("%s_SW" % anim_name)
		_: 
			print("How??")
	
	
func change_direction(dir: Type.Direction):
	facing = dir
