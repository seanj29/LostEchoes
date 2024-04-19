class_name State
extends Node


signal transitioned(new_state_name: StringName)

## Logic to be executed when the machine enters this state
func Enter() -> void:
	pass

## Logic to be executed when machine exits this state
func Exit() -> void:
	pass

## Logic to be executed every frame
func Update(delta: float) -> void:
	pass
## Physics version of [method Update]
func Physics_update(delta: float) -> void:
	pass