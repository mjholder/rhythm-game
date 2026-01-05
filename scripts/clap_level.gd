extends Level
class_name ClapLevel

@export var clap_hands: AnimatedSprite2D
@export var song_player: AudioStreamPlayer

func play_song():
	song_player.play()


func on_action():
	super.on_action()
	if clap_hands.is_playing():
		clap_hands.set_frame_and_progress(1, 1.0)
	else:
		clap_hands.play("clap")
		var time = song_player.get_playback_position() + AudioServer.get_time_since_last_mix()
		# Compensate for output latency.
		time -= AudioServer.get_output_latency()
		print("Time is: ", time)
