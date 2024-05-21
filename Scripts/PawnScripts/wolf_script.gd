@icon("res://Assets/Icons/wolf-4-svgrepo-com.svg")
class_name WolfScript

extends CharInput



#  Add a possible timer so that the transition will always happen after a set amount of time.
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var home_pos := global_position

@onready var nav: NavigationAgent2D = $NavigationAgent2D
@onready var raycast: RayCast2D = $RayCast2D


@export var ReachedRadius := 20

@export_category("RoamingProperties")
@export var RoamMinRadius := 30
@export var RoamMaxRadius := 80

@export_category("ChaseProperties")
@export var Player: PlayerInput


var sight_distance = 75
var dir: Vector2
var can_see_player: bool = false

var target_pos: Vector2

func _ready():

	nav.target_desired_distance = ReachedRadius

func _physics_process(_delta):
	super(_delta)
	raycast.target_position = global_position.direction_to(Player.global_position) * sight_distance
	if raycast.is_colliding():
		var collider := raycast.get_collider()
		if collider != TileMap:
			can_see_player = true
		else:
			return
	else:
		can_see_player = false

	if raycast.target_position != target_pos:
		target_pos = raycast.target_position
		queue_redraw()

## Using this to debug
func _draw():
	draw_line(Vector2.ZERO, target_pos, Color.RED, 5)

func randomPoint() -> Vector2:

	var angle = randf_range(0, TAU)
	var randomRadius = randf_range(RoamMinRadius, RoamMaxRadius)

	var x = home_pos.x + randomRadius * cos(angle)
	var y = home_pos.y + randomRadius * sin(angle)

	return Vector2(x, y)

func direction_state() -> Vector2:
		return dir


	
