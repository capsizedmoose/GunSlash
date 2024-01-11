class_name SlashState
extends State

signal on_slash();

@export var next_state: State
var slash: PackedScene = preload("res://scenes/slash.tscn");
@export var delay: float = .5;
var timer:float = 0;

func enter() -> void:
	timer = 0;
	GameManager.time_scale = .1;
	super();

func process_frame(delta:float) -> State:
	timer += delta / GameManager.time_scale
	if(timer < delay):
		return null;
	GameManager.time_scale = 1;
	on_slash.emit();
	var new_slash: Slash = slash.instantiate() as Slash;
	GameManager.root.add_child(new_slash);
	var from_pos = parent.global_position;
	var to_pos = parent.target.global_position;
	var new_intersection: PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.create(from_pos,to_pos);
	new_intersection.collide_with_bodies = false;
	new_intersection.collide_with_areas = true;
	var exclude: Array[RID] = [];
	new_intersection.exclude = exclude;
	var done:bool = false;
	var tries: int = 0;
	while(!done && tries < 100):
		var intersection = parent.get_world_2d().direct_space_state.intersect_ray(new_intersection);
		if !intersection:
			done = true;
			break;
		var collider = intersection["collider"];
		if(collider == null):
			done = true;
			break;
		exclude.append(intersection["rid"]);
		new_intersection.exclude = exclude;
		if(collider is HitBox):
			var hitbox:HitBox = collider as HitBox;
			if(hitbox.team != Game.Team.PLAYER):
				hitbox.try_damage_chunk(1,1);
		tries+=1;
	new_slash.init(from_pos,to_pos,.25);
	parent.global_position = parent.target.global_position;
	return next_state;
