class_name ProjectileData;

var position: Vector2;
var indirect_position: Vector2;
var velocity: Vector2;
var lifetime: float;
var flagged_for_deletion: bool;

func get_position() -> Vector2:
	return position + indirect_position;