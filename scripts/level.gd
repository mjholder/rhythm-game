extends Node2D
class_name Level

var _is_recording: bool = false
var _is_player: bool = false

signal track_saved(track_name: String, track: Array[float], is_player: bool)
signal song_finished(track_name: String)

func record_action_track(is_player: bool):
    _is_player = is_player
    _is_recording = true

func play_song():
    pass

func on_action():
    pass
