class_name RoamingBehaviourState
extends BehaviourState


## Logic to be executed when the machine enters this state
func Enter() -> void:
	super()
	var nav :NavigationAgent2D = actor.nav
	print("I'm roaming baby!!")
	print(nav)

## Logic to be executed when machine exits this state
func Exit() -> void:
	pass

## Logic to be executed every frame
func Update(_delta: float) -> void:
	pass
## Physics version of [method Update]
func Physics_update(_delta: float) -> void:
	pass
