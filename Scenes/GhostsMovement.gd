extends AnimatedSprite2D


@onready var Level := get_node("/root/Level")

var ReplayDict: Dictionary

var currentFrame: int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	var LoadedReplay: ReplayGhost = Level.load_new("res://Resources/Ghosts/replay1.tres")
	ReplayDict = LoadedReplay.Replay


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	currentFrame += 1
	var ActionsTaken = ReplayDict.get(currentFrame) 
	if ActionsTaken:
		print(ActionsTaken)

