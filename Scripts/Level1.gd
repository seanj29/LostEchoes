extends Node2D

@export var levelNumber: int = 1
@export var ReplayResource: ReplayGhost

# Will have to make a manual save function, thing the issue is this doesn't get triggered consistently

func _ready():
    ReplayResource.level = levelNumber

func save(resource: Resource, Path: String):
    ResourceSaver.save(resource, Path)

func load_new(Path: String) -> ReplayGhost:
    if ResourceLoader.exists(Path, "ReplayGhost"):
        return ResourceLoader.load(Path, "ReplayGhost")
    else:
        return null