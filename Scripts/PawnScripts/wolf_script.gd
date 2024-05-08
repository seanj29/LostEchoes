@icon("res://Assets/Icons/wolf-4-svgrepo-com.svg")
class_name WolfScript

extends CharInput

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


func _ready():
    sprite.play("Idle_NE")

func _physics_process(_delta):
    pass