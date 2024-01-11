class_name HitBox extends Area2D

@export var health_component: ChunkHealthSystem;

@export var team : Game.Team

func damage(amount: int):
	if health_component:
		health_component.try_damage(amount)

func try_damage_chunk(amount: int,shield_damage:int):
	if health_component:
		health_component.try_damage_chunk(amount,shield_damage)	