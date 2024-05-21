class_name AttackBehaviorState
extends BehaviourState

var actor_speed: float
@export var distance_squared_to_target: float = 250.0

## Logic to be executed when the machine enters this state
func Enter():
	actor_speed = actor.SPEED
	actor.SPEED = 0


## Logic to be executed every frame
func Update(_delta) -> void:
	super(_delta)

	if actor.global_position.distance_squared_to(actor.Player.global_position) > distance_squared_to_target:
		if can_see_player:
			transitioned.emit("ChasingBehaviourState")
		else:
			transitioned.emit("SearchBehaviourState")
	else:
		## add logic here for the actor to attack the player
		print("Attacking!!!")



	


## Logic to be executed when machine exits this state
func Exit():
	actor.SPEED = actor_speed


func change() -> void:
	transitioned.emit("ChasingBehaviourState")