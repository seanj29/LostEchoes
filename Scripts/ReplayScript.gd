class_name ReplayGhost
extends Resource

# Array with (Frame, array of actions/inputs, currentState) 
# Could even make an object called "Frame" which has a number, array of actions and playerstate variables?
@export var levelNumber: int
@export var level_name: String
@export var Replay: Dictionary

func _init(ReplayDict = {}, levelNo = 0, level_string = "None"):

    levelNumber = levelNo
    level_name = level_string
    Replay = ReplayDict
