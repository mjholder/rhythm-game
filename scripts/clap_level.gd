extends Level
class_name ClapLevel

@export var clap_hands: AnimatedSprite2D

func on_action():
	super.on_action()
	if clap_hands.is_playing():
		clap_hands.set_frame_and_progress(1, 1.0)
	else:
		clap_hands.play("clap")
