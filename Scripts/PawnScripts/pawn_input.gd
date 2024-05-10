class_name PawnInput

extends CharInput

@export var TeleportTimer: Timer

@export var TeleportUnits = 150

var is_teleporting: bool

var ReplayDict: Dictionary


func _physics_process(_delta):
	super(_delta)
	var direction := direction_state()
	is_teleporting = teleport_state()
	if is_teleporting:
		teleport_self(direction)


func teleport_self(dir: Vector2 = Vector2.UP) -> void:
	global_position += (dir * TeleportUnits)
