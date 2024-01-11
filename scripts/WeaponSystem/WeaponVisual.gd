@tool
class_name WeaponVisual
extends Node2D

@export var grip: Grip;
@export var blade: Blade;
@export var weapon: Weapon;

@export var grip_sprite: Sprite2D
@export var blade_sprite: Sprite2D 

@export var create: bool = false: 
	set(value):
		create_weapon();
		
@export var modifier: StatModifier;
@export var add_modifier: bool = false: 
	set(value):
		weapon.add_modifier(StatModifier.copy(modifier))



func create_weapon() -> void:
	weapon = Weapon.new(grip,blade)
	weapon_updated()
	
func weapon_updated() -> void:
	grip_sprite.texture = weapon.grip.sprite;
	blade_sprite.texture = weapon.blade.sprite;
	
