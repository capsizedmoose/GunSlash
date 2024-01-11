class_name HurtBox extends Area2D

signal on_collide_with_hitbox(hitbox: HitBox)

@export var team : Game.Team

func _ready() -> void:
	area_entered.connect(check_hitbox_collision);

func check_hitbox_collision(hitbox:Node2D) -> void:
	if hitbox is HitBox:
		on_collide_with_hitbox.emit(hitbox as HitBox);
