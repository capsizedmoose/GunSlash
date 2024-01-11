class_name Slash extends Node2D

@onready var line: Line2D = $Line2D;

var duration:float = 1;
var n:float = 0;
@export var width:float = 10;

func init(start:Vector2,end:Vector2,_duration:float = 1) -> void:
	var points: Array[Vector2] = [];
	for i in range(10.0):
		points.append(lerp(start,end,i/10.0));
	line.points = points;
	line.width = width
	duration = _duration
	n = duration;

func _process(delta: float) -> void:
	n -= delta
	line.width = width * n/duration;
	if n <=0:
		queue_free();
