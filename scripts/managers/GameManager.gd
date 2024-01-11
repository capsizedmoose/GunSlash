extends Node;

signal on_time_scale_changed(new_time_scale: float);
signal on_play_area_changed(new_play_area: Rect2);

@export var root: Node;
@export var transition: TransitionManager;
@export var camera_rig: CameraRig;
@export var player_health_bar: HealthBarWithShield;
var player: Player;

@export var play_area: Rect2:
	set(value):
		play_area = value;
		on_play_area_changed.emit(value);

func set_player(p:Player) -> void:
	player = p;
	player_health_bar.set_health_system.call_deferred(player.health);


var time_scale: float = 1:
	set(value):
		time_scale = value;
		on_time_scale_changed.emit(value);

func shake_camera(strength: float, duration: float):
	camera_rig.shaker.shake(strength, duration);