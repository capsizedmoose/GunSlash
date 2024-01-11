class_name Cursor
extends Node2D

func _process(_delta: float) -> void:
	global_position = get_global_mouse_position();
	var rect: Rect2 = GameManager.play_area
	var size = rect.size*.5;
	global_position = global_position.clamp(rect.position - size,rect.position + size);
