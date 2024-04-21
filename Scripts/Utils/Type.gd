class_name Type

enum Direction {N, NE, E, SE, S, SW, W, NW, NULL}

const VectorNE := (Vector2.UP + Vector2.RIGHT) / sqrt(2)
const VectorNW := (Vector2.UP + Vector2.LEFT) / sqrt(2)
const VectorSE := (Vector2.DOWN + Vector2.RIGHT) / sqrt(2)
const VectorSW := (Vector2.DOWN + Vector2.LEFT) / sqrt(2)


static func convertVectorToDirection(dir: Vector2) -> Direction:
	

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
		_:
			return Direction.NULL
		
	
static func convertDirectiontoVector(dir: Direction) -> Vector2:
	

	match dir:

		Direction.N:
			return Vector2.UP
		Direction.NE:
			return VectorNE
		Direction.E:
			return Vector2.RIGHT
		Direction.SE:
			return VectorSE
		Direction.W:
			return Vector2.LEFT
		Direction.NW:
			return VectorNW
		Direction.S:
			return Vector2.DOWN
		Direction.SW:
			return VectorSW
		_:
			return Vector2.ZERO

