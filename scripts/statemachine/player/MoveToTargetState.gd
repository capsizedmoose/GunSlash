class_name MoveToTargetState
extends State

@export var max_speed: float;

@export var charge_state: ChargeState;

func process_frame(delta:float) -> State:
	if !parent  || !parent.target:
		print("no move or target")
		return null;
	var new_position: Vector2 = parent.global_position.move_toward(parent.target.global_position,delta*max_speed)
	parent.global_position = new_position;
	return null;
	
	
func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("charge"):
		return charge_state;
	return null
