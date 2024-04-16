extends AnimatedSprite2D

class_name AnimScript

enum Direction {N, NE, E, SE, S, SW, W, NW}
var current_direction: Direction

var VectorNE := (Vector2.UP + Vector2.RIGHT).normalized()
var VectorNW := (Vector2.UP + Vector2.LEFT).normalized()
var VectorSE := (Vector2.DOWN + Vector2.RIGHT).normalized()
var VectorSW := (Vector2.DOWN + Vector2.LEFT).normalized()

# Called when the node enters the scene tree for the first time.
func play_walk(dir: Vector2):

	current_direction = _calc_direction(dir)

	match current_direction:
		Direction.N:
			play("Walk_N")
		Direction.NE:
			play("Walk_NE")
		Direction.E:
			play("Walk_E")
		Direction.SE:
			play("Walk_SE")
		Direction.W:
			play("Walk_W")
		Direction.NW:
			play("Walk_NW")
		Direction.S: 
			play("Walk_S")
		Direction.SW: 
			play("Walk_SW")
		
		_: 
			print("for me, impossible")

func play_idle():

	match current_direction:

		Direction.N:
			play("Idle_N")
		Direction.NE:
			play("Idle_NE")
		Direction.E:
			play("Idle_E")
		Direction.SE:
			play("Idle_SE")
		Direction.W:
			play("Idle_W")
		Direction.NW:
			play("Idle_NW")
		Direction.S: 
			play("Idle_S")
		Direction.SW:
			play("Idle_SW")
		_: 
			print("How??")


func _calc_direction(dir: Vector2):

	match dir:
		
		Vector2.UP:
			return Direction.N
		VectorNE:
			return Direction.NE
		Vector2.RIGHT:
			return Direction.E
		VectorSE:
			return Direction.SE
		Vector2.LEFT:
			return Direction.W
		VectorNW:
			return Direction.NW
		Vector2.DOWN:
			return Direction.S
		VectorSW:
			return Direction.SW


