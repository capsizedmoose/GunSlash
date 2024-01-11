class_name Flash extends SubViewportContainer

var delay:float = 0.0

func flash(duration:float) -> void:
	material.set_shader_parameter("flash", true)
	delay = duration;

func _process(delta):
	if delay > 0.0:
		delay -= delta
		if delay <= 0.0:
			delay = 0.0
			material.set_shader_parameter("flash", false)