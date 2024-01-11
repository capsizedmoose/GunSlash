class_name StatModifier
extends Resource

@export var stat: Stat.StatType;
@export var value: int;

static func copy(old:StatModifier) -> StatModifier:
	var new_modifier = StatModifier.new()
	new_modifier.stat = old.stat;
	new_modifier.value = old.value;
	return new_modifier;
