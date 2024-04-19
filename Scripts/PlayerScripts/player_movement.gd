class_name PlayerMovement

extends PawnMovement


@export var CurrentReplayResource: ReplayGhost



var ActionArray: Array[String] = ["Up", "Down", "Left", "Right", "Attack"]

func _ready():

	ReplayDict = CurrentReplayResource.Replay



func _physics_process(_delta):

	var direction = Input.get_vector("Left", "Right", "Up", "Down")

	if direction:
		velocity = direction * SPEED
		super.calc_direction(direction)
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



