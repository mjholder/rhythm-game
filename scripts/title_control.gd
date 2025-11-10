extends Control

@export var radius: float = 100.0
@export var offset: Vector2 = Vector2.ONE
@export var title: Label
@export var shadows: Array[Label] = []

func _process(delta: float):
    for i in shadows.size():
        shadows[i].position = offset * i + Vector2(radius * cos(i * 2 * PI / shadows.size()), radius * sin(i * 2 * PI / shadows.size()))