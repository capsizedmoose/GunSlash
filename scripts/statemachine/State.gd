class_name State
extends Node

signal on_enter();
signal on_exit();

var parent:Player;

func enter() -> void:
	on_enter.emit();
	pass

func exit() -> void:
	on_exit.emit();
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null
