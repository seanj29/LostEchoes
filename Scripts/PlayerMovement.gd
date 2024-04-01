extends CharacterBody2D


@export var SPEED = 300.0
@export var FRICTION = 1500.00

var ReplayTest:Array[ReplayFrame] = []

func _physics_process(_delta):


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	# TODO add better actions blah blah

	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO

	move_and_slide()


func _unhandled_key_input(event: InputEvent):

	if event.is_action_pressed("ui_up"):
		var FrameObject = ReplayFrame.new(Engine.get_physics_frames(), ["Move UP"])
		ReplayTest.append(FrameObject)
		print("FrameList:")
		print(event.as_text())
		for Frame in ReplayTest:
			print("	Frame: %s 	Actions: %s"  % [Frame.FrameNumber, Frame.ActionArr])	


class ReplayFrame:

	var FrameNumber: int
	var ActionArr: Array[String]

	func _init(Frame: int, Actions: Array[String]):
		FrameNumber = Frame
		ActionArr = Actions	