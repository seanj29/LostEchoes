class_name BehaviourStateMachine
extends StateMachine

@export var actor: CharInput

func _ready():
	for child in get_children():
		if child is BehaviourState:
			# Add the state to  the `Dictionary` using its `name`
			states[child.name] = child
		# Connect the state machine to the `transitioned` signal of all children
			child.transitioned.connect(on_child_transitioned)
		else:
			push_warning("State machine contains child which is not a BehaviourState")
	# Start execution of the initial state
	# state_stack.push_back(current_state)
	current_state.Enter()