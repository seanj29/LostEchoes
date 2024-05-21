class_name SearchBehaviourState
extends BehaviourState

var old_home: Vector2
var nav: NavigationAgent2D
var next_path_pos: Vector2
var last_target: Vector2

## Logic to be executed when the machine enters this state
func Enter():
	super()
	old_home = actor.home_pos
	actor.home_pos = actor.global_position

	nav = actor.nav
	nav.target_position = actor.randomPoint()


## Logic to be executed every frame
func Update(_delta) -> void:
	super(_delta)

	next_path_pos = nav.get_next_path_position()


	if nav.is_navigation_finished():
		
		nav.target_position  = actor.randomPoint()

	actor.dir = actor.global_position.direction_to(next_path_pos)
	
	if can_see_player:
		transitioned.emit("ChasingBehaviourState")

	


## Logic to be executed when machine exits this state
func Exit():
	super()
	actor.home_pos = old_home


func change() -> void:
	transitioned.emit("IdleBehaviourState")