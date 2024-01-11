class_name HealthBarWithShield extends Control

@export var health_system: ChunkHealthSystem;
@export var health_bar: ChunkHealthBar;
@export var shield_bar: Range;
@export var flash:Flash;

func _ready() -> void:
	if health_system != null:
		set_health_system(health_system,false);

func set_health_system(new_health_system: ChunkHealthSystem,should_disconnect:bool = true) -> void:
	if(health_system != null && should_disconnect):
		health_system.shield_health_changed.disconnect(update_shield);
		health_system.health_damaged.disconnect(take_damage);
	health_system = new_health_system;
	health_system.initialize();
	health_bar.initialize_chunks(health_system);
	shield_bar.max_value = health_system.shield_health;
	shield_bar.value = health_system.current_shield_health;
	health_system.shield_health_changed.connect(update_shield);
	health_system.health_damaged.connect(take_damage);

func update_shield(new_shield: int) -> void:
	shield_bar.value = new_shield;

func take_damage() -> void:
	flash.flash(.025);	
