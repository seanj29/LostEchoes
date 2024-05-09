class_name IdleBehaviourState
extends BehaviourState

func Enter():
    super()
    actor.SPEED = 0
    



func change() -> void:
    transitioned.emit("RoamingBehaviourState")