extends Level
class_name ClapLevel

@export var clap_hands: AnimatedSprite2D
@export var instructor_clap_hands: AnimatedSprite2D
@export var clap_audio: AudioStreamPlayer
@export var clap_reverb: AudioStreamPlayer

@export var clap_window: float = 0.1

var instructor_index: int = 0
var player_index: int = 0

func _ready():
	track_name = "clap"

func _process(delta: float):
	if song_player.is_playing() and not _is_recording:
		var time = get_time()
		if player_index < _player_track.size() and player_track(_player_track, time, clap_window, player_index):
			player_index += 1
			print("Player hit note at time: ", time)
		if instructor_index < _instructor_track.size() and instructor_track(_instructor_track, time, instructor_index):
			instructor_index += 1
			print("Instructor hit note at time: ", time)
			instructor_action()

func instructor_action():
	super.instructor_action()
	clap_reverb.play()
	if instructor_clap_hands.is_playing() and instructor_clap_hands.animation == "clap":
		instructor_clap_hands.set_frame_and_progress(1, 1.0)
	else:
		instructor_clap_hands.play("clap")

func play_song(player_track: Array[float], instructor_track: Array[float]):
	_player_track = player_track
	_instructor_track = instructor_track
	song_player.play()

func on_action():
	super.on_action()
	clap_audio.play()

	var time = get_time()
	if player_accuracy(_player_track, time, clap_window, player_index):
		instructor_clap_hands.play("right")
	else:
		instructor_clap_hands.play("wrong")

func _on_music_player_finished() -> void:
	if _is_recording:
		if _is_player:
			track_saved.emit("clap", _player_track, true)
			print("Player finished")
		else:
			track_saved.emit("clap", _instructor_track, false)
			print("Instructor finished")

		_is_recording = false
	song_finished.emit("clap")
