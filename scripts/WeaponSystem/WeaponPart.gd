class_name WeaponPart extends Resource

enum MaterialType{
	WOOD,
	STEEL,
	IRON
}

@export var materialType: MaterialType;
@export var sprite: Texture2D
@export var durability_min : int;
@export var durability_max : int;
