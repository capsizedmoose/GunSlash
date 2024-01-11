extends Control

signal on_progress_updated(progress: float);
signal on_active_changed(active: bool);

var active : bool = false:
	set(value):
		active = value;
		on_active_changed.emit(active)

var quitting : bool = false;

var progress: float = 0:
	set(value):
		progress = value;
		on_progress_updated.emit(progress);

@export var speed: float = 3.0;
@export var fart: AudioStreamPlayer;

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Quit"):
		active = true;
	elif event.is_action_released("Quit"):
		active = false;

 
func _process(delta: float) -> void:
	if quitting:
		return;
	if active:
		progress += delta * speed;
		if progress > 1:
			quitting = true;
			_quit();
	else:
		progress = 0;


func _quit() -> void:
	fart.play();
	await fart.finished;
	get_tree().quit();
