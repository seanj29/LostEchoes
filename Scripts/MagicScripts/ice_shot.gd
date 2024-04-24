class_name IceShot
extends Area2D

const FORWARDRATIO := 0.05

@export var max_range := 200
@export var BulletSpeed := 400


@onready var Owner: PawnInput
@onready var current_direction: Type.Direction

signal direction_changed(direction: Type.Direction)
var _travelled_distance = 0

func _ready():
	direction_changed.emit(current_direction)
	position += Type.convertDirectiontoVector(current_direction) * BulletSpeed * FORWARDRATIO
	

func _physics_process(delta: float):
	var distance := BulletSpeed * delta
	var motion := Type.convertDirectiontoVector(current_direction) * BulletSpeed * delta

	position += motion
	
	_travelled_distance += distance
	if _travelled_distance > max_range:
		queue_free()


