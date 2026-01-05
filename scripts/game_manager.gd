extends Node2D
class_name GameManager

@export var level_parent: Node2D
@export var current_level: Level

func _ready() -> void:
	current_level = level_parent.get_children()[0]

func select_level(level: Level) -> void:
	current_level.queue_free()
	current_level = level
	level_parent.add_child(current_level)
	current_level.play_song()

func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("action"):
		current_level.on_action()


func _on_levelselectbutton_pressed() -> void:
	print("levelselectbutton pressed")
	select_level(load("res://scenes/clap_level.tscn").instantiate())
