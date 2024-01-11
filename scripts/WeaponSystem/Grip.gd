class_name Grip extends WeaponPart

enum GemSlotType{
	SQUARE,
	ROUND,
	TRIANGLE
}

@export var gem_slot_type : GemSlotType;
@export var base_health: int = 1; 
