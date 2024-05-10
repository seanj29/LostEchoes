class_name BehaviourState
extends State

@onready var parent: BehaviourStateMachine = get_parent()
@onready var actor: CharInput = parent.actor
var state_timer: Timer

@export_group("Internal timer Properties")
@export var TIMER_MIN: float = 0.5
@export var TIMER_MAX: float = 3.0


func Enter():
    state_timer = Timer.new()
    add_child(state_timer)

    var Timer_sec := snappedf(randf_range(TIMER_MIN, TIMER_MAX), 0.1)
    state_timer.start(Timer_sec)

    if not state_timer.timeout.is_connected(change):
        state_timer.timeout.connect(change)

func Exit():

    if state_timer.timeout.is_connected(change):
        state_timer.timeout.disconnect(change)
    state_timer.queue_free()


func change() -> void:
    pass
