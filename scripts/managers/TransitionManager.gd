class_name TransitionManager extends Control

@onready var _animator : AnimationPlayer = $AnimationPlayer

func fade_in():
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	_animator.play("FadeIn")
	await _animator.animation_finished
	
func fade_out():
	mouse_filter = Control.MOUSE_FILTER_STOP
	_animator.play("FadeOut")
	await _animator.animation_finished
