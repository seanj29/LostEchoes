extends AnimScript

## This script provides movement and animation to the Ghosts within the scene.
##
@onready var Level := get_node("/root/Level")

## The ID of the Ghost. Used for loading it's replays from the level.
@export_range(1, 5,) var GhostID: int = 1

var ReplayDict: Dictionary

enum ActionsEnum {MOVE_LEFT,MOVE_RIGHT, MOVE_UP, MOVE_DOWN, SPECIAL}

var currentFrame: int = 0

## This dict stores the curent state of the various buttons
# TODO Replace the ActionsState with a bitflag instead of a dict? maybe
var ActionsState := {Up_pressed = false, Down_pressed = false, Left_pressed = false, Right_pressed = false}

# Called when the node enters the scene tree for the first time.
func _ready():
	var LoadedReplay: ReplayGhost = Level.load_ghost_by_id(GhostID)
	if LoadedReplay:
		ReplayDict = LoadedReplay.Replay
		print("GhostMovement.gd: resource loaded")
	else:
		print("GhostMovement.gd: No Resource found for Ghost Id %d" % GhostID)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	

	if ReplayDict:
		currentFrame += 1
		var ActionsTaken = ReplayDict.get(currentFrame) 
		if ActionsTaken:
			for Action in ActionsTaken:
				if Action is String:
					parseAction(Action)

	Movement(ActionsState)


## Fuction that parses the Actions in the [member ReplayDict].[br] 
## Parses iin a string and changes the global [member ActionsState] dict accordingly. 
func parseAction(Action: String):
	match Action.to_lower():
		"up_pressed":
			ActionsState.Up_pressed = true
		"up_released":
			ActionsState.Up_pressed = false
		"down_pressed":
			ActionsState.Down_pressed = true
		"down_released":
			ActionsState.Down_pressed = false
		"left_pressed":
			ActionsState.Left_pressed = true
		"left_released":
			ActionsState.Left_pressed = false
		"right_pressed":
			ActionsState.Right_pressed = true
		"right_released":
			ActionsState.Right_pressed = false
		var anything_else:
			print(anything_else)
	return


func Movement(StateDict: Dictionary) -> void:
	var current_direction_vector = Vector2.ZERO
	if StateDict.Up_pressed:
		position.y -= 5
		current_direction_vector.y = -1
	if StateDict.Down_pressed:
		position.y += 5
		current_direction_vector.y = 1
	if StateDict.Left_pressed:
		position.x -= 5
		current_direction_vector.x = -1
	if StateDict.Right_pressed:
		position.x += 5
		current_direction_vector.x = 1

	play_anim(current_direction_vector.normalized())
	return


## Called to decide which animation to played depending on whether the sprite is moving or not. [br]
## [param vec] needs to be a normalized of length.
func play_anim(vec: Vector2):
	if vec:
		play_walk(vec)
	else:
		play_idle()