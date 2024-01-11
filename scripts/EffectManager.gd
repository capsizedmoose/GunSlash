extends Node

@onready var blood_explosion: PackedScene = preload("res://scenes/blood_explosion.tscn")

func play_effect(pos:Vector2,effect:Effect) -> void:
	var fx = effect.scene.instantiate();
	GameManager.root.add_child(fx);
	fx.global_position = pos;