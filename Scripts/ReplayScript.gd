class_name ReplayGhost
extends Resource

# Array with (Frame, array of actions/inputs, currentState) 
# Could even make an object called "Frame" which has a number, array of actions and playerstate variables?
@export var level: int
@export var Replay: Dictionary

func _init(ReplayDict = {}, levelNo = 0):

    level = levelNo
    Replay = ReplayDict
