class_name Shaker extends Node2D

var rnd = RandomNumberGenerator.new();

var strength = 0;
var fade = 0;
var duration = 0;

func shake(_strength: float, _fade: float) -> void:
	if _fade <= 0:
		return;	
	strength = _strength;
	fade = _fade;
	duration = 1;

func _process(delta: float) -> void:
	if duration < 0:
		return;
	duration -= delta / fade;
	if duration < 0:
		duration = 0;
		position = Vector2.ZERO;
		return;
	var current_shake = strength * duration;
	position = Vector2(rnd.randf_range(-current_shake,current_shake), rnd.randf_range(-current_shake,current_shake));
