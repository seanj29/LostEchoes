extends Node

@export var IceScene: PackedScene

@onready var pawns := get_tree().get_nodes_in_group("pawns")


func _ready():
	for pawn in pawns:
		if pawn is PawnInput:
			pawn.attack_pressed.connect(_spawn_shot)


func _spawn_shot(who: PawnInput, pos: Vector2, dir: Type.Direction) :
	var ice_shot := IceScene.instantiate()
	ice_shot.Owner = who
	ice_shot.global_position = pos
	ice_shot.current_direction = dir
	add_child(ice_shot)
