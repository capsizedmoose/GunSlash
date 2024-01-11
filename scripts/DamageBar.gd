class_name DamageBar extends Control;

var value_bar: Range:
	get:
		return $Value;

var delay_bar: Range:
	get:
		return $Delay;

var timer: Timer:
	get:
		return $Timer;	

@export var delay: float = 1.0;
@export var speed: float = 4.0;
var freeze_delay: bool = false;

@export var min_value: float = 0.0:
	set(new_value):
		min_value = new_value;
		delay_bar.min_value = min_value;
		value_bar.min_value = min_value;

@export var max_value: float = 100.0:
	set(new_value):
		max_value = new_value;
		delay_bar.max_value = max_value;
		value_bar.max_value = max_value;

@export var value: float = 100.0;

func set_value(new_value: float, should_delay:bool = true) -> void:
	value = new_value;
	if(!should_delay):
		delay_bar.value = new_value;
	else:
		timer.start(delay);
		freeze_delay = true;
	value_bar.value = new_value;

func _ready() -> void:
	timer.timeout.connect(_on_delay_timeout);

func _on_delay_timeout() -> void:
	freeze_delay = false;

func _process(delta):
	if(freeze_delay):
		return;
	delay_bar.value = lerpf(delay_bar.value, value, delta * 4.0);
