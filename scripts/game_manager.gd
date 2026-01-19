extends Node2D
class_name GameManager

@export var level_parent: Node2D
@export var current_level: Level
@export var main_menu: Control
@export var level_select: Control
@export var pause_menu: Control

var tracks: Variant

func _ready() -> void:
	current_level.track_saved.connect(_on_track_saved)
	current_level.song_finished.connect(_on_song_finished)
	current_level = level_parent.get_children()[0]
	_load_tracks()

func _load_tracks():
	var json = JSON.new()
	var error = json.parse(FileAccess.open("res://config/tracks.json", FileAccess.READ).get_as_text())
	if error != OK:
		print("Error loading tracks: ", error)
		return
	tracks = json.data

func save_track(track_name: String, track: Array[float], is_player: bool) -> void:
	tracks["songs"][track_name]["player_track" if is_player else "instructor_track"] = track
	FileAccess.open("res://config/tracks.json", FileAccess.WRITE).store_string(JSON.stringify(tracks))

func select_level(level: Level) -> void:
	current_level.queue_free()
	current_level = level
	level_parent.add_child(current_level)
	current_level.track_saved.connect(_on_track_saved)
	current_level.song_finished.connect(_on_song_finished)
	hide_all_menus()

func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("action"):
		current_level.on_action()
	if event.is_action_pressed("record_player"):
		current_level.record_action_track(true)
		current_level.play_song()
	if event.is_action_pressed("record_instructor"):
		current_level.record_action_track(false)
		current_level.play_song()
	if event.is_action_pressed("start"):
		current_level.play_song()

func hide_all_menus() -> void:
	main_menu.hide()
	level_select.hide()
	pause_menu.hide()

func show_main_menu() -> void:
	main_menu.show()
	level_select.hide()
	pause_menu.hide()

func show_level_select() -> void:
	main_menu.hide()
	level_select.show()
	pause_menu.hide()

func show_pause_menu() -> void:
	main_menu.hide()
	level_select.hide()
	pause_menu.show()

func _on_levelselectbutton_pressed() -> void:
	print("levelselectbutton pressed")
	select_level(load("res://scenes/clap_level.tscn").instantiate())

func _on_track_saved(track_name: String, track: Array[float], is_player: bool) -> void:
	save_track(track_name, track, is_player)

func _on_song_finished(track_name: String) -> void:
	print("Song finished: ", track_name)
