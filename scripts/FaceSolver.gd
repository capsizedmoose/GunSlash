extends AnimatedSprite2D


enum States{
	default,
	happy,
	dead,
	hurt
}

var state = States.default;

var timer:float = 0;

func _process(delta: float) -> void:
	timer -= delta;
	match state:
		States.default:
			animation = "default"
		States.happy:
			animation = "happy"
		States.dead:
			animation = "dead"
		States.hurt:
			animation = "hurt"
			if timer <= 0:
				state = States.default

func set_state(new_state:States, new_timer:float = .5) -> void:
	state = new_state
	timer = new_timer

func set_state_to_hurt() -> void:
	set_state(States.hurt, 0.2);

func set_state_to_dead() -> void:
	set_state(States.dead);