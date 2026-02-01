extends Node2D
class_name Level

@export var song_player: AudioStreamPlayer

var _player_track: Array[float] = []
var _instructor_track: Array[float] = []

var _is_recording: bool = false
var _is_player: bool = false

var track_name: String = ""

signal track_saved(track_name: String, track: Array[float], is_player: bool)
signal song_finished(track_name: String)


func get_time():
	var time = song_player.get_playback_position() + AudioServer.get_time_since_last_mix()
	# Compensate for output latency.
	time -= AudioServer.get_output_latency()
	return time

func record_action_track(is_player: bool):
	_is_player = is_player
	_is_recording = true

func instructor_action():
	pass

func instructor_track(track: Array[float], time: float, index: int):
	if time >= track[index]:
		instructor_action()
		return true
	return false

func player_track(track: Array[float], time: float, window: float, index: int):
	if time >= track[index] + (window / 2):
		return true
	return false

func player_accuracy(track: Array[float], time: float, window: float, index: int):
	if time >= track[index] - (window / 2) and time <= track[index] + (window / 2):
		return true
	return false

func play_song(player_track: Array[float], instructor_track: Array[float]):
	pass

func on_action():
	var time = get_time()
	if _is_recording:
		if _is_player:
			_player_track.append(time)
		else:
			_instructor_track.append(time)
