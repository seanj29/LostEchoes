class_name IdleBehaviourState
extends BehaviourState

var actor_speed: float

func Enter():
	super()
	actor_speed = actor.SPEED
	actor.SPEED = 0
	
func Exit():
	super()
	actor.SPEED = actor_speed

func Update(_delta):
	super(_delta)
	if can_see_player:
		transitioned.emit("ChasingBehaviourState")
		

func change() -> void:
	transitioned.emit("RoamingBehaviourState")