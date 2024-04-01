extends CharacterBody2D

@onready var TopNode := get_node("/root/Level")


@export var SPEED = 300.0
@export var FRICTION = 1500.00
@export var ReplayResource: ReplayGhost

#  All instances of res:// in filename will be changed to user:// pre production
"""
Using this multiline string to stop the weirdness with links above

"""

var ReplayDict: Dictionary
var ActionArray: Array[String] = ["Up", "Down", "Left", "Right", "Special"] # Cam't use InputMap.get_actions() here as the array it produces it too large, would need to weight up preformance vs code readability.

func _ready():
	
	ReplayResource.level = TopNode.levelNumber

	var ReplayLoaded := load_new("res://Resources/Ghosts/replay1.tres")
	if ReplayLoaded:
		ReplayDict = ReplayLoaded.Replay
		print("resource loaded")
	else:
		ReplayDict = ReplayResource.Replay
		print("Resource not found")


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
		if !ReplayDict.has(Frame):
			ReplayDict[Frame] = actionsThisFrame
		else:
			ReplayDict[Frame].append_array(actionsThisFrame)



	# if event.is_action_pressed("Up"):
	# 	if !ReplayDict.has(Frame):
	# 		ReplayDict[Frame] = ["Up"]
	# 	else:
	# 		ReplayDict[Frame].append("Up")
	# if event.is_action_pressed("Down"):
	# 	if !ReplayDict.has(Frame):
	# 		ReplayDict[Frame] = ["Down"]
	# 	else:
	# 		ReplayDict[Frame].append("Down")
	# if event.is_action_pressed("Left"):
	# 	if !ReplayDict.has(Frame):
	# 		ReplayDict[Frame] = ["Left"]
	# 	else:
	# 		ReplayDict[Frame].append("Left")
	# if event.is_action_pressed("Right"):
	# 	if !ReplayDict.has(Frame):
	# 		ReplayDict[Frame] = ["Right"]
	# 	else:
	# 		ReplayDict[Frame].append("Right")
	
	# for iFrame: int in ReplayDict.keys():
	# 	print("Frame: %s	ActionArray %s" % [iFrame, ReplayDict[iFrame]])
	# print("\n")

	if event.is_action_pressed("Save"):
		save(ReplayResource, "res://Resources/Ghosts/replay1.tres")



func save(resource: Resource, Path: String):
	ResourceSaver.save(resource, Path)

func load_new(Path: String) -> ReplayGhost:
	if ResourceLoader.exists(Path, "ReplayGhost"):
		return ResourceLoader.load(Path, "ReplayGhost")
	else:
		return null