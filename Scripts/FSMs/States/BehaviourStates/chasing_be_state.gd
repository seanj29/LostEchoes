class_name ChasingBehaviourState
extends BehaviourState

@export var sight_distance: int  = 75
@export var distance_squared_to_target: float = 150.0

var nav: NavigationAgent2D
var ray: RayCast2D
var target_pos: Vector2
var next_path_pos: Vector2

## Logic to be executed when the machine enters this state
func Enter():
	actor.sight_distance = sight_distance
	nav = actor.nav
	ray = actor.raycast

	
	
	print("chasing player!!")



## Logic to be executed every frame
func Update(_delta):
	super(_delta)

	if ray.is_colliding():
		target_pos = ray.get_collision_point()
		nav.target_position = target_pos

	next_path_pos = nav.get_next_path_position()

	if nav.is_navigation_finished():
		if nav.is_target_reached():
			if actor.global_position.distance_squared_to(actor.Player.global_position) < distance_squared_to_target:
				transitioned.emit("AttackBehaviorState")
		else:
			print("where did you go??")
			transitioned.emit("SearchBehaviourState")
			
	actor.dir = actor.global_position.direction_to(next_path_pos)
	


## Physics version of [method Update]
func Physics_update(_delta):
	pass


## Logic to be executed when machine exits this state
func Exit():
	pass


