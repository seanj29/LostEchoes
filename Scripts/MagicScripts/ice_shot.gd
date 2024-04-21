class_name IceShot
extends Area2D

@export var max_range := 200
@export var BulletSpeed := 200

@onready var Owner: PawnMovement = get_parent()
@onready var current_direction := Owner.current_direction

signal direction_changed(direction: Type.Direction)
var _travelled_distance = 0

func _ready():
	direction_changed.emit(Owner.current_direction)

func _physics_process(delta: float):
	var distance := BulletSpeed * delta
	var motion := Type.convertDirectiontoVector(current_direction) * BulletSpeed * delta

	position += motion
	
	_travelled_distance += distance
	if _travelled_distance > max_range:
		queue_free()


