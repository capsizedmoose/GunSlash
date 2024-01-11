extends Panel

func _ready() -> void:
	size = GameManager.play_area.size;
	GameManager.on_play_area_changed.connect(_on_play_area_changed)

func _on_play_area_changed(new_area: Rect2) -> void:
	size = new_area.size;

func _process(delta: float) -> void:
	var shift: Vector2 = get_viewport_rect().size / 2;
	shift -= GameManager.play_area.size / 2;
	global_position = -GameManager.camera_rig.camera.global_position + shift;
