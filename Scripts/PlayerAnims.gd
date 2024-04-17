extends AnimatedSprite2D

class_name AnimScript

## Enum for each Direction possible in 2d isometric space
enum Direction {N, NE, E, SE, S, SW, W, NW}

## The current direction the sprite is facing. [br]
## if it it is given a default, then the Sprite will start in that direction.
var current_direction: Direction

## Following consts are added to be able to use in switch case statements.
var VectorNE := (Vector2.UP + Vector2.RIGHT).normalized()
var VectorNW := (Vector2.UP + Vector2.LEFT).normalized()
var VectorSE := (Vector2.DOWN + Vector2.RIGHT).normalized()
var VectorSW := (Vector2.DOWN + Vector2.LEFT).normalized()


## Play the relevant walk animation for a sprite.[br]
## [param dir] is the current direction the body is intending to go in, in Vector2 format.
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


## Play the sprites Idle animation based on current direction.
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


## This function calculates the direction, based on [param dir], which is usually called during the [method play_walk] function.
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


