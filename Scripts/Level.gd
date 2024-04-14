extends Node2D

@export var levelNumber: int = 1
@export var ReplayResource: ReplayGhost

var count: int = 0
var levelPath = "user://Level_%s" % [levelNumber]
const PATH = "user://replay1.tres"
# Will have to make a manual save function, thing the issue is this doesn't get triggered consistently

func _ready():
    ReplayResource.levelNo = levelNumber

func save(resource: Resource):
    count += 1
    if !ResourceLoader.exists(PATH):
        ResourceSaver.save(resource, PATH)
    else:
        ResourceSaver.save(resource, "%s_ver%0*d" % [PATH, count])

func load_new() -> ReplayGhost:
    if ResourceLoader.exists(PATH):
        print("%s being loaded" % PATH)
        return ResourceLoader.load(PATH, "ReplayGhost")
    else:
        return null

func delete ():
    var global_path = ProjectSettings.globalize_path(PATH)
    print("Attempting to delete %s" % global_path)
    if ResourceLoader.exists(PATH):
        OS.move_to_trash(global_path)
        print("%s deleted" % global_path)
    else:
        print("Could not find resource to delete at path: %s" % global_path)