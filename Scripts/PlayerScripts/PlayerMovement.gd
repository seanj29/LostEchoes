class_name PlayerChar

extends CharacterBody2D


@onready var Level := get_node("/root/Level")


@export var CurrentReplayResource: ReplayGhost

@export_group("Player Physics")
@export var SPEED = 250.0

var VectorNE := (Vector2.UP + Vector2.RIGHT).normalized()
var VectorNW := (Vector2.UP + Vector2.LEFT).normalized()
var VectorSE := (Vector2.DOWN + Vector2.RIGHT).normalized()
var VectorSW := (Vector2.DOWN + Vector2.LEFT).normalized()

## Emitted when the direction changes
signal direction_changed(direction: Type.Direction)


## The current direction the sprite is facing. [br]
## if it it is given a default, then the Sprite will start in that direction.
var current_direction: Type.Direction

var ReplayDict: Dictionary

var ActionArray: Array[String] = ["Up", "Down", "Left", "Right", "Attack"]

func _ready():

	ReplayDict = CurrentReplayResource.Replay



func _physics_process(_delta):

	var direction = Input.get_vector("Left", "Right", "Up", "Down")

	if direction:
		velocity = direction * SPEED
		calc_direction(direction)
	else:
		velocity = Vector2.ZERO


	move_and_slide()


func _unhandled_key_input(event: InputEvent):
	
	record_input(event)
	if event.is_action_pressed("Save"):
		Level.save(CurrentReplayResource)
	if event.is_action_pressed("Delete"):
		Level.delete_all()



## internal function to record the state of any actions taken by the player this frame, and pass it into the level save.
func record_input(event: InputEvent):
	
	var Frame := Engine.get_physics_frames()

	var actionsMap := ActionArray.map(
		func(action: String): 
		if event.is_action_pressed(action):
			return "%s_pressed" % action
		elif event.is_action_released(action):
			return "%s_released" % action
		else:
			return
		)

	var actionsThisFrame := actionsMap.filter(
		func(action) -> bool:
		return action != null
	)

		
	if not actionsThisFrame.is_empty():
		if !ReplayDict.has(Frame):
			ReplayDict[Frame] = actionsThisFrame
		else:
			ReplayDict[Frame].append_array(actionsThisFrame)
			
	return



## This function calculates the direction, based on [param dir], which is usually called during the [method play_walk] function.
func calc_direction(dir: Vector2):

	match dir:
		
		Vector2.UP:
			current_direction = Type.Direction.N
		VectorNE:
			current_direction = Type.Direction.NE
		Vector2.RIGHT:
			current_direction = Type.Direction.E
		VectorSE:
			current_direction = Type.Direction.SE
		Vector2.LEFT:
			current_direction = Type.Direction.W
		VectorNW:
			current_direction = Type.Direction.NW
		Vector2.DOWN:
			current_direction = Type.Direction.S
		VectorSW:
			current_direction = Type.Direction.SW
	
	direction_changed.emit(current_direction)