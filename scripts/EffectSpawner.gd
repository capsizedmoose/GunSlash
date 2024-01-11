extends Node2D

@export var effect:Effect;

func play_effect_on_me(new_effect:Effect = null):
	if new_effect != null:
		EffectManager.play_effect(global_position, new_effect);
		return;
	EffectManager.play_effect(global_position, effect);	