class_name Projectile extends Node2D

var data: ProjectileData;
var modifiers: Array[ProjectileModifier] = [];

func _process(delta: float) -> void:
	var scaled_delta = delta * GameManager.instance.gameSpeed;
	data.lifetime += scaled_delta
	data.indirect_position = Vector2.ZERO;
	for modifier in modifiers:
		modifier.modify_data(data, scaled_delta);
	if data.flagged_for_deletion:
		handle_deletion();
	global_position = data.position + data.indirect_position;


func handle_deletion() -> void:
	queue_free();