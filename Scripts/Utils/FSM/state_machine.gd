class_name StateMachine
extends Node

@export var current_state: State
var states: Dictionary = {}

## Last element in the state array will be the most recent state, similar to a stack
# var state_stack: Array[State]


func _ready():
	for child in get_children():
		if child is State:
			# Add the state to  the `Dictionary` using its `name`
			states[child.name] = child
		# Connect the state machine to the `transitioned` signal of all chil
			child.transitioned.connect(on_child_transitioned)
		else:
			push_warning("State machine contains child which is not a State")
	# Start execution of the initial state
	# state_stack.push_back(current_state)
	current_state.Enter()

func _process(delta):
	current_state.Update(delta)

func _physics_process(delta):
	current_state.Physics_update(delta)

func on_child_transitioned(new_state_name: StringName) -> void:
	var new_state = states.get(new_state_name)
	if new_state != null:
		if new_state != current_state:
			current_state.Exit()
			new_state.Enter()
			current_state = new_state
	else:
		push_warning("Called transition on a state that does nto exist called %s" % new_state_name)
