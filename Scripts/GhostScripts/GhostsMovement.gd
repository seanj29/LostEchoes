extends CharacterBody2D


## Handles movement for the ghost, and makes sure it collides properly with walls.
@onready  var Level = get_node("/root/Level")

@onready var SpriteScript: AnimScript = $MainGhostAnim

## The ID of the Ghost. Used for loading it's replays from the level.
@export_range(1, 5,) var GhostID: int = 1

@export_group("Ghost Physics")
@export var SPEED = 250.0

enum ActionsEnum {MOVE_LEFT,MOVE_RIGHT, MOVE_UP, MOVE_DOWN, SPECIAL}
var ReplayDict: Dictionary
var currentFrame: int = 0

## This dict stores the curent state of the various buttons
# TODO Replace the ActionsState with a bitflag instead of a dict? maybe
var ActionsState := {Up_pressed = false, Down_pressed = false, Left_pressed = false, Right_pressed = false}


func _ready():
	var LoadedReplay: ReplayGhost = Level.load_ghost_by_id(GhostID)
	if LoadedReplay:
		ReplayDict = LoadedReplay.Replay
		print("GhostMovement.gd: resource loaded")
	else:
		print("GhostMovement.gd: No Resource found for Ghost Id %d" % GhostID)


func _physics_process(_delta):
	
	if ReplayDict:
		currentFrame += 1
		var ActionsTaken = ReplayDict.get(currentFrame) 
		if ActionsTaken:
			for Action in ActionsTaken:
				if Action is String:
					parseAction(Action)

	var direction = cal_direction_vector(ActionsState)
	SpriteScript.play_anim(direction)

	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO

	move_and_slide()

## Fuction that parses the Actions in the [member ReplayDict].[br] 
## Parses a string action and changes the global [member ActionsState] dict accordingly. 
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

func cal_direction_vector(StateDict: Dictionary) -> Vector2:
	var current_direction_vector = Vector2(0, 0)
	if StateDict.Up_pressed:
		current_direction_vector.y -= 1
	if StateDict.Down_pressed:
		current_direction_vector.y += 1
	if StateDict.Left_pressed:
		current_direction_vector.x -= 1
	if StateDict.Right_pressed:
		current_direction_vector.x += 1
	
	return current_direction_vector.normalized()