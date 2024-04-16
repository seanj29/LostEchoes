extends Node2D

@export var levelNumber: int = 1
@export var ReplayResource: ReplayGhost
@export var MaxGhostAmount: int = 5

var currentGhostCount: int = 1

var baseDir = "user://Level_%d" % levelNumber
var savePathDir = "%s/Ghosts" % baseDir

# Will have to make a manual save function, thing the issue is this doesn't get triggered consistently

func _ready():
    ReplayResource.levelNumber = levelNumber

func save(resource: Resource) -> Error:
    var dir_error := _check_dir(savePathDir)
    var replayName = "replay_%02d.tres" % currentGhostCount
    var savePath = "%s/%s" % [savePathDir, replayName]



    if dir_error != OK:
        print("Could not create directory located in %s , Error: %s" % [ ProjectSettings.globalize_path(savePathDir), error_string(dir_error)])
        return dir_error
    else:
        currentGhostCount += 1
        print(savePath)
        if currentGhostCount > MaxGhostAmount:
            currentGhostCount = 1

        if !ResourceLoader.exists(savePath):
            ResourceSaver.save(resource, savePath)
            print("Saving ghost %s" % savePath)
        else:
            delete_one(savePath)
            print("Deleting ghost at %s" % savePath)
            ResourceSaver.save(resource, savePath)
            print("Saving ghost %s" % savePath)

    return OK


func load_ghost_by_id(ghostID: int) -> ReplayGhost:

    var ghostPath = "%s/replay_%02d.tres" % [savePathDir, ghostID]
    if !ResourceLoader.exists(ghostPath):
        return null
    else:
        print("%s being loaded" % ghostPath)
        return ResourceLoader.load(ghostPath, "ReplayGhost")

func delete_all() -> Error:
    var delete_dir := DirAccess.open(savePathDir)
    if !delete_dir:
        var error = DirAccess.get_open_error()
        printerr("Could not open/find directory %s, Error: %s" % [ ProjectSettings.globalize_path(savePathDir), error_string(error)])
        return error
    else:
        var file_array = delete_dir.get_files()
        for file in file_array:
            var delete_error = delete_one(savePathDir + "/" + file)
            if delete_error:
                return delete_error
        return OK



func delete_one(FilePathToDelete: String) -> Error:
    var global_path = ProjectSettings.globalize_path(FilePathToDelete)
    print("Attempting to delete %s" % global_path)
    if !ResourceLoader.exists(global_path):
        printerr("Could not find resource to delete at path: %s" % global_path)
        return ERR_FILE_NOT_FOUND
    else:
        var error = OS.move_to_trash(global_path)
        if error:
            return error
        else:
            print("%s deleted" % global_path)
            return OK
        


func _check_dir(dir: String) -> Error:
    if !DirAccess.dir_exists_absolute(dir):
        var err = DirAccess.make_dir_recursive_absolute(dir)
        return err
    else:
        return OK