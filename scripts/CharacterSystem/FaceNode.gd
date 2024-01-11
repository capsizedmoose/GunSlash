class_name FaceNode extends Node2D

@export var face: Face;

@onready var head_shape_sprite: Sprite2D = $HeadShape;
@onready var eye_l_sprite: AnimatedSprite2D = $EyeL;
@onready var eye_r_sprite: AnimatedSprite2D = $EyeR;
@onready var nose_sprite: AnimatedSprite2D = $Nose;
@onready var mouth_sprite: AnimatedSprite2D = $Mouth;


func set_face(_face:Face) -> void:
	face = _face;
	head_shape_sprite.texture = face.head_shape.texture;
	eye_l_sprite.sprite_frames = face.eye_l.sprites;
	eye_r_sprite.sprite_frames = face.eye_r.sprites;
	nose_sprite.sprite_frames = face.nose.sprites;
	mouth_sprite.sprite_frames = face.mouth.sprites;
