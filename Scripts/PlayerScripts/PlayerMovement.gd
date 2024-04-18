extends CharacterBody2D

@onready var Level := get_node("/root/Level")
@onready var animated_sprite: AnimScript = $Sprite


@export var CurrentReplayResource: ReplayGhost

@export_group("Player Physics")
@export var SPEED = 250.0

#  All instances of res:// in filename will be changed to user:// pre production
"""
Using this multiline string to stop the weirdness with links above

"""

var ReplayDict: Dictionary

var ActionArray: Array[String] = ["Up", "Down", "Left", "Right", "Special"] # Cam't use InputMap.get_actions() here as the array it produces it too large, would need to weight up preformance vs code readability.

func _ready():

	ReplayDict = CurrentReplayResource.Replay



func _physics_process(_delta):

	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	if direction:
		velocity = direction * SPEED
		animated_sprite.play_walk(direction)
	else:
		velocity = Vector2.ZERO
		animated_sprite.play_idle()


	move_and_slide()


func _unhandled_key_input(event: InputEvent):
	
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
		var currentX = position.x
		var currentY = position.y
		actionsThisFrame.append(["x = ",currentX])	
		actionsThisFrame.append(["y = ",currentY])
		if !ReplayDict.has(Frame):
			ReplayDict[Frame] = actionsThisFrame
		else:
			ReplayDict[Frame].append_array(actionsThisFrame)


	if event.is_action_pressed("Save"):
		Level.save(CurrentReplayResource)
	if event.is_action_pressed("Delete"):
		Level.delete_all()


