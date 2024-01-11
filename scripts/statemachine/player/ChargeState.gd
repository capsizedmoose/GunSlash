class_name ChargeState
extends State

@export var next_state: State
@export var weapon: Node2D;
@export var fire_point: Node2D;
@export var bullet_spawner: BulletSpawner;

func process_input(event: InputEvent) -> State:
	if event.is_action_released("charge"):
		return next_state;
	return null

var shoot_delay:float = .1;
var shot_speed:float = 2000;
var shoot_time:float = 0;

func process_frame(delta:float) -> State:
	weapon.global_rotation = parent.get_angle_to(parent.target.global_position);
	shoot_time += delta;
	while shoot_time > shoot_delay:
		shoot_time -= shoot_delay;
		shoot();
	return null;

func shoot() -> void:
	var point = fire_point.global_position;
	var angle = fire_point.global_rotation + deg_to_rad(randf_range(-10,10));
	var direction = Vector2.from_angle(angle)
	var velocity = direction.normalized() * shot_speed;
	bullet_spawner.shoot(point,velocity);
