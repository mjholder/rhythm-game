extends Level
class_name ClapLevel

@export var clap_hands: AnimatedSprite2D
@export var song_player: AudioStreamPlayer

var _player_track: Array[float] = []
var _instructor_track: Array[float] = []

func play_song():
	song_player.play()

func on_action():
	super.on_action()

	var time = song_player.get_playback_position() + AudioServer.get_time_since_last_mix()
	# Compensate for output latency.
	time -= AudioServer.get_output_latency()
	print("Time is: ", time)
	
	if _is_recording:
		if _is_player:
			_player_track.append(time)
		else:
			_instructor_track.append(time)
	if clap_hands.is_playing():
		clap_hands.set_frame_and_progress(1, 1.0)
	else:
		clap_hands.play("clap")


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