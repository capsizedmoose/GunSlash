class_name Weapon
extends Resource

var grip: Grip;
var blade: Blade;

@export var stat_modifiers: Array[StatModifier]

@export var attack_value: int;
@export var healt_value: int;

func _init(_grip:Grip,_blade:Blade) -> void:
	grip = _grip;
	blade = _blade;
	update_stat_values();

func add_modifier(_modifier:StatModifier) -> void:
	stat_modifiers.append(_modifier);
	update_stat_values();

func update_stat_values() -> void:
	attack_value = blade.base_attack;
	healt_value = grip.base_health;
	for modifier in stat_modifiers:
		match(modifier.stat):
			Stat.StatType.HEALTH:
				healt_value += modifier.value;
			Stat.StatType.ATTACK:
				attack_value += modifier.value;
