class_name TimeScaledParticles
extends GPUParticles2D

func _ready() -> void:
	GameManager.on_time_scale_changed.connect(update_speed_scale)
	update_speed_scale(GameManager.time_scale)

func update_speed_scale(new_scale:float)-> void:
	speed_scale = new_scale;
	
