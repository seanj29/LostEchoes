extends CharacterBody2D


@export var SPEED = 300.0
@export var FRICTION = 1500.00

var ReplayTest: Dictionary = {}
var ActionArray: Array[String] = ["Up", "Down", "Left", "Right", "Special"] # Cam't use InputMap.get_actions() here as the array it produces it too large, would need to weight up preformance vs code readability.

func _physics_process(_delta):

	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO

	move_and_slide()


func _unhandled_key_input(event: InputEvent):
	
	var Frame := Engine.get_physics_frames()
	var filteredArray := ActionArray.filter(
		func(action:String) -> bool:
		return event.is_action(action)
	)

	var actionsThisFrame := filteredArray.map(
		func(action: String): 
		if event.is_action_pressed(action):
			return "%s_pressed" % action
		elif event.is_action_released(action):
			return "%s_released" % action
		else:
			return action
		)
		
	if not actionsThisFrame.is_empty():
		if !ReplayTest.has(Frame):
			ReplayTest[Frame] = actionsThisFrame
		else:
			ReplayTest[Frame].append_array(actionsThisFrame)



	# if event.is_action_pressed("Up"):
	# 	if !ReplayTest.has(Frame):
	# 		ReplayTest[Frame] = ["Up"]
	# 	else:
	# 		ReplayTest[Frame].append("Up")
	# if event.is_action_pressed("Down"):
	# 	if !ReplayTest.has(Frame):
	# 		ReplayTest[Frame] = ["Down"]
	# 	else:
	# 		ReplayTest[Frame].append("Down")
	# if event.is_action_pressed("Left"):
	# 	if !ReplayTest.has(Frame):
	# 		ReplayTest[Frame] = ["Left"]
	# 	else:
	# 		ReplayTest[Frame].append("Left")
	# if event.is_action_pressed("Right"):
	# 	if !ReplayTest.has(Frame):
	# 		ReplayTest[Frame] = ["Right"]
	# 	else:
	# 		ReplayTest[Frame].append("Right")
	
	# for iFrame: int in ReplayTest.keys():
	# 	print("Frame: %s	ActionArray %s" % [iFrame, ReplayTest[iFrame]])
	# print("\n")


