class_name BehaviourState
extends State

@onready var parent: BehaviourStateMachine = get_parent()
@onready var actor: CharInput = parent.actor
@onready var Timer_sec := snappedf(randf_range(TIMER_MIN, TIMER_MAX), 0.1)
@onready var state_timer := get_tree().create_timer(Timer_sec)

@export_group("Timer Properties")
@export var TIMER_MIN: float = 0.5
@export var TIMER_MAX: float = 3.0


func Enter():
    
    if not state_timer.timeout.is_connected(change):
        state_timer.timeout.connect(change)


func change() -> void:
    pass