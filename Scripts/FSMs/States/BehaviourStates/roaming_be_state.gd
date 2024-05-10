class_name RoamingBehaviourState
extends BehaviourState

var nav: NavigationAgent2D
var target_pos: Vector2
var next_path_pos: Vector2
var last_target: Vector2
var MinimumVectorDistance: float = 50

func Enter() -> void:
	super()

	nav = actor.nav
	last_target = nav.target_position

	target_pos = actor.randomPoint()
	while last_target.distance_to(target_pos) < MinimumVectorDistance:
		print(last_target.distance_to(target_pos))
		target_pos = actor.randomPoint()

	nav.target_position = target_pos


	if not nav.navigation_finished.is_connected(change):
		nav.navigation_finished.connect(change)

	print("I'm roaming baby!!")


func Physics_update(_delta: float) -> void:
	next_path_pos = nav.get_next_path_position()
	if nav.is_navigation_finished():
		change()
	actor.dir = actor.global_position.direction_to(next_path_pos)
	


func change() -> void:
	transitioned.emit("IdleBehaviourState")