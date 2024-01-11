class_name ChunkHealthSystem extends Node

signal chunks_changed(chunks: int);
signal chunk_health_changed(chunks: int);
	
signal current_chunk_changed(current_chunk: int)
signal health_changed(health: int);

signal health_damaged();
signal health_depleted();
signal chunk_destroyed();

signal shield_health_changed(shield_health: int);
signal shield_damaged();
signal shield_broken();

signal shield_clash();

@export var shield_health:int = 100;
@export var shield_recharge_rate:float = 10;
@export var shield_recharge_delay:float = 2;
@export var shield_break_duration:float = 3;
var current_shield_health:float;
var current_shield_delay:float;
var shield_is_broken:bool = false;
var dead:bool = false;

@export var chunks: int = 1:
	set(value):
		chunks = value;
		chunks_changed.emit(chunks);

@export var chunk_health:int = 10:
	set(value):
		chunk_health = value;
		chunk_health_changed.emit(chunk_health);

var current_chunk: int;
var health: int;


var initialized: bool = false;
func initialize() -> void:
	initialized = true;
	current_chunk = chunks-1;
	health = chunk_health;
	current_shield_health = shield_health;

func get_max_health() -> int:
	return chunks*chunk_health;

func get_current_health() -> int:
	return (current_chunk * chunk_health) + health;

func damage_chunk(amount: int) -> void:
	chunk_destroyed.emit();
	current_chunk -= amount;
	health = chunk_health;
	if current_chunk < 0:
		current_chunk = 0;
		health = 0;
		dead = true;
		health_depleted.emit();
	else:
		replenish_shield();
	health_changed.emit(get_current_health());
	current_chunk_changed.emit(current_chunk);

func damage(amount: int) -> void:
	if dead:
		return;
	health -= amount;
	if health > 0:
		health_changed.emit(get_current_health());
		health_damaged.emit();
		return;
	damage_chunk(1);

func try_damage_chunk(amount: int, shield_damage:int) -> void:
	if dead:
		return;
	if shield_is_broken:
		damage_chunk(amount);
		return;
	if current_shield_health > 0:
		try_damage(shield_damage);
		shield_clash.emit();

func try_damage(amount: int) -> void:
	if(dead):
		return;
	if shield_is_broken:
		damage(amount);
		return;
	if current_shield_health > 0:
		current_shield_health -= amount;
		current_shield_delay = shield_recharge_delay;
		if current_shield_health <= 0:
			current_shield_health = 0;
			shield_is_broken = true;
			current_shield_delay = shield_break_duration;	
			shield_broken.emit();
		shield_health_changed.emit(current_shield_health);
		shield_damaged.emit();
		return;

func _process(delta: float) -> void:
	if dead:
		return;
	if current_shield_delay > 0:
		current_shield_delay -= delta * GameManager.time_scale;
		if current_shield_delay <= 0:
			current_shield_delay = 0;
			if shield_is_broken:	
				replenish_shield();
		return;
	if current_shield_health < shield_health:
		shield_recharge(shield_recharge_rate * delta * GameManager.time_scale);

func shield_recharge(amount: float) -> void:
	current_shield_health += amount;
	if current_shield_health > shield_health:
		current_shield_health = shield_health;
	shield_health_changed.emit(current_shield_health);

func replenish_shield() -> void:
	shield_is_broken = false;
	current_shield_health = shield_health;
	shield_health_changed.emit(current_shield_health);