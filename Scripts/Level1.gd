extends Node2D

@export var levelNumber: int = 1
@export var ReplayResource: ReplayGhost
var count: int = 0
const PATH = "user://replay1.tres"
# Will have to make a manual save function, thing the issue is this doesn't get triggered consistently

func _ready():
    ReplayResource.level = levelNumber

func save(resource: Resource):
    count += 1
    if !ResourceLoader.exists(PATH):
        ResourceSaver.save(resource, PATH)
    else:
        ResourceSaver.save(resource, "%s_ver%0*d" % [PATH, count])

func load_new() -> ReplayGhost:
    if ResourceLoader.exists(PATH):
        return ResourceLoader.load(PATH, "ReplayGhost")
    else:
        return null

func delete ():
    if ResourceLoader.exists(PATH):
        OS.move_to_trash(ProjectSettings.globalize_path(PATH))
    else:
        print("Could not find resource at path: %s" % PATH)