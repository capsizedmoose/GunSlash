class_name HealthComponent extends Node

signal health_changed(new_health: int);
signal health_depleted();
signal health_increased(amount: int);
signal health_decresed(amount: int);
signal max_health_changed(new_max_health: int);

@export var max_health: int:
	set(value):
		var old_max_health = max_health;
		max_health = value;
		if old_max_health == max_health:
			return;
		if current_health > max_health:
			current_health = max_health;
		max_health_changed.emit(max_health);

@export var current_health: int:
	set(value):
		var old_health = current_health;
		current_health = clamp(value, 0, max_health);
		var dif = current_health - old_health;
		if dif == 0:
			return;
		health_changed.emit(current_health);
		if dif < 0:
			health_decresed.emit(dif);
		else:
			health_increased.emit(dif);
		if current_health == 0:
			health_depleted.emit();

func damage(amount: int) -> void:
	current_health -= amount;

func heal(amount: int) -> void:
	current_health += amount;
