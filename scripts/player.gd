class_name Player
extends CharacterBody2D

@export var statemachine: Statemachine;
@export var target: Node2D;
@export var health: ChunkHealthSystem;

func _ready() -> void:
	statemachine.init(self);
	GameManager.set_player(self);

func _process(delta: float) -> void:
	statemachine.process_frame(delta * GameManager.time_scale);
	
func _input(event: InputEvent) -> void:
	statemachine.process_input(event);
	
func _physics_process(delta: float) -> void:
	statemachine.process_physics(delta * GameManager.time_scale);
	