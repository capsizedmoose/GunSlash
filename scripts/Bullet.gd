class_name Bullet
extends HurtBox

var duration: float = 2.0;
var speed: float = 100.0;
var lifetime: float = 0;

func _ready() -> void:
	super();
	on_collide_with_hitbox.connect(_on_collide_with_hitbox);

func _process(delta: float) -> void:
	var scaled_delta: float =  delta * GameManager.time_scale;
	lifetime += scaled_delta
	global_position += global_transform.x.normalized() * speed * scaled_delta;
	if lifetime >= duration:
		queue_free();

func _on_collide_with_hitbox(hitbox: HitBox) -> void:
	if hitbox.team != team:
		hitbox.damage(1);
		queue_free();
