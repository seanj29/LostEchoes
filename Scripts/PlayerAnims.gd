extends AnimatedSprite2D

class_name AnimScript

enum Direction {N, NE, E, SE, S, SW, W, NW}
var current_direction: Direction

var VectorNE := (Vector2.UP + Vector2.RIGHT).normalized()
var VectorNW := (Vector2.UP + Vector2.LEFT).normalized()
var VectorSE := (Vector2.DOWN + Vector2.RIGHT).normalized()
var VectorSW := (Vector2.DOWN + Vector2.LEFT).normalized()

# Called when the node enters the scene tree for the first time.
func play_walk():
	# TODO: iimplement the rest of the directions both here
	match current_direction:
		Direction.N:
			play("Walk_N")
		Direction.E:
			play("Walk_E")
		Direction.S: 
			play("Walk_S")
		_: 
			print("WHy is this not wokring aaaah")

func play_idle():
	# TODO: and here
	match current_direction:

		Direction.N:
			play("Idle_N")
		Direction.E:
			play("Idle_E")
		Direction.S: 
			play("Idle_S")
		_: 
			print("haven't implemented yet oops")


func _physics_process(_delta):

	var direction := Input.get_vector("Left", "Right", "Up", "Down")

	match direction:
		
		Vector2.UP:
			current_direction = Direction.N
		VectorNE:
			current_direction = Direction.NE
		Vector2.RIGHT:
			current_direction = Direction.E
		VectorSE:
			current_direction = Direction.SE
		Vector2.LEFT:
			current_direction = Direction.W
		VectorNW:
			current_direction = Direction.NW
		Vector2.DOWN:
			current_direction = Direction.S
		VectorSW:
			current_direction = Direction.SW


