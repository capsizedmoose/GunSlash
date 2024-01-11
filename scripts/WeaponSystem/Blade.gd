class_name Blade extends WeaponPart

enum DamageType{
	SLASH,
	PIERCE,
	BLUNT
}

@export var damage_type: DamageType;
@export var base_attack: int = 1;
