extends Node2D
class_name GameManager

@export var current_level: Level

func _ready() -> void:
    pass

func select_level(level: Level) -> void:
    pass

func _process(delta: float) -> void:
    pass

func _input(event: InputEvent) -> void:
    if event.is_action_pressed("action"):
        current_level.on_action()
