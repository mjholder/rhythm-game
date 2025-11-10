extends Control

@export var radius: float = 100.0
@export var offset: float = 0.0
@export var speed: float = 1.0
@export var title: Label
@export var shadows: Array[Label] = []

var angle: float = 0.0

func _ready() -> void:
	for i in shadows.size():
		shadows[i].position = title.position + Vector2(radius * cos(offset + i * 2 * PI / shadows.size()), radius * sin(offset + i * 2 * PI / shadows.size()))

func _process(delta: float) -> void:
	# Increase the angle over time
	angle += speed * TAU * delta  # TAU = 2 * PI
	
	# Compute position along the circle
	var x = title.position.x + radius * cos(angle)
	var y = title.position.y + radius * sin(angle)
	
	title.position = Vector2(x, y)

	for i in shadows.size():
		var offset_angle = angle - deg_to_rad(offset * (i + 1))
		x = shadows[i].position.x + radius * cos(offset_angle)
		y = shadows[i].position.y + radius * sin(offset_angle)
		shadows[i].position = Vector2(x, y)