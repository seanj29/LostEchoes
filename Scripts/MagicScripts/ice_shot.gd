class_name IceShot
extends Area2D

const FORWARDRATIO := 0.05

@export var max_range := 200
@export var BulletSpeed := 400


@onready var Owner: PawnInput
@onready var current_direction: Type.Direction
@onready var attack_str: int = Owner.stats.attack
signal direction_changed(direction: Type.Direction)
var _travelled_distance = 0

func _ready():
	direction_changed.emit(current_direction)
	position += Type.convertDirectiontoVector(current_direction) * BulletSpeed * FORWARDRATIO
	if not body_entered.is_connected(whoCollided):
		body_entered.connect(whoCollided)
	

func _physics_process(delta: float):
	var distance := BulletSpeed * delta
	var motion := Type.convertDirectiontoVector(current_direction) * BulletSpeed * delta

	position += motion
	
	_travelled_distance += distance
	if _travelled_distance > max_range:
		queue_free()

func whoCollided(body: Node2D) -> void:

	if body is CharInput and not body == Owner:

		body.attack_rec(Owner, attack_str)
		# Uncomment below to delete the projectile on hit
		#queue_free()
	
	return
	

