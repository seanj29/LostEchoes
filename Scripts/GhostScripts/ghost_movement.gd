class_name GhostMovement

extends PawnMovement

## Handles movement for the ghost, and makes sure it collides properly with walls.


## The ID of the Ghost. Used for loading it's replays from the level.
@export_range(1, 5,) var GhostID: int = 1


var currentFrame: int = 0

## This dict stores the curent state of the various buttons
# TODO Replace the ActionsState with a bitflag instead of a dict? maybe
var ActionsState := {Up_pressed = false, Down_pressed = false, Left_pressed = false, Right_pressed = false, Attack_pressed = false}


func _ready():
	var LoadedReplay: ReplayGhost = Level.load_ghost_by_id(GhostID)
	if LoadedReplay:
		ReplayDict = LoadedReplay.Replay
		print("GhostMovement.gd for Ghost Id %d says: resource loaded" % GhostID)
	else:
		print("GhostMovement.gd for Ghost Id %d says: No Resource found" % GhostID)


func _physics_process(_delta):
	
	

	if ReplayDict:
		currentFrame += 1
		var ActionsTaken = ReplayDict.get(currentFrame) 
		if ActionsTaken:
			for Action in ActionsTaken:
				if Action is String:
					parseAction(Action)

		
	var direction = calc_direction_vector(ActionsState)
	# SpriteScript.anim_picker(direction)

	if direction:
		velocity = direction * SPEED
		super.calc_direction(direction)
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
		"attack_pressed":
			ActionsState.Attack_pressed = true
		"attack_released":
			ActionsState.Attack_pressed = false
		var anything_else:
			printerr("%s has not been implemented yet!" % anything_else)
	return

func calc_direction_vector(StateDict: Dictionary) -> Vector2:
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