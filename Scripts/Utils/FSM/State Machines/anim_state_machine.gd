class_name AnimStateMachine
extends StateMachine

@export var sprite: AnimatedSprite2D
@export var actor: PawnMovement


func _ready():
	for child in get_children():
		if child is AnimState:
			# Add the state to  the `Dictionary` using its `name`
			states[child.name] = child
		# Connect the state machine to the `transitioned` signal of all children
			child.transitioned.connect(on_child_transitioned)
		else:
			push_warning("State machine contains child which is not a AnimState")
	# Start execution of the initial state
	# state_stack.push_back(current_state)
	current_state.Enter()
