class_name BulletSpawner
extends Node2D

signal on_bullet_spawned();

var bullet_scene: PackedScene = preload("res://scenes/bullet.tscn");

func shoot(point:Vector2,velocity:Vector2) -> Bullet:
	var bullet: Bullet = bullet_scene.instantiate() as Bullet;
	GameManager.root.add_child(bullet);
	GameManager.shake_camera(2,.15);
	bullet.global_position = point;
	bullet.global_rotation = velocity.angle();
	bullet.speed = velocity.length();
	on_bullet_spawned.emit();
	return bullet;