# meta-description: Easy template to easily makes states
# meta-default: true    
extends State


## Logic to be executed when the machine enters this state
func Enter() -> void:
	pass


## Logic to be executed every frame
func Update(_delta: float) -> void:
	pass


## Physics version of [method Update]
func Physics_update(_delta: float) -> void:
	pass


## Logic to be executed when machine exits this state
func Exit() -> void:
	pass

