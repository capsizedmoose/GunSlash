class_name Spring
extends Resource

var damping : float
var frequency: float

var type

var values: Array[SpringData] = [SpringData.new(),
	SpringData.new(),
	SpringData.new(),
	SpringData.new()]

var target_value:
	set(value):
		target_value = value;
		type = typeof(target_value)

func _init(_frequency:float,_damping:float):
	frequency = _frequency
	damping = _damping

func update_spring(delta:float):
	match typeof(target_value):
		TYPE_FLOAT:
			SpringMotion.CalcDampedSimpleHarmonicMotion(values[0],target_value,delta,frequency,damping)
		TYPE_VECTOR2:
			SpringMotion.CalcDampedSimpleHarmonicMotion(values[0],target_value.x,delta,frequency,damping)
			SpringMotion.CalcDampedSimpleHarmonicMotion(values[1],target_value.y,delta,frequency,damping)
		TYPE_VECTOR3:
			SpringMotion.CalcDampedSimpleHarmonicMotion(values[0],target_value.x,delta,frequency,damping)
			SpringMotion.CalcDampedSimpleHarmonicMotion(values[1],target_value.y,delta,frequency,damping)
			SpringMotion.CalcDampedSimpleHarmonicMotion(values[2],target_value.z,delta,frequency,damping)
		TYPE_VECTOR4:
			SpringMotion.CalcDampedSimpleHarmonicMotion(values[0],target_value.x,delta,frequency,damping)
			SpringMotion.CalcDampedSimpleHarmonicMotion(values[1],target_value.y,delta,frequency,damping)
			SpringMotion.CalcDampedSimpleHarmonicMotion(values[2],target_value.z,delta,frequency,damping)
			SpringMotion.CalcDampedSimpleHarmonicMotion(values[3],target_value.w,delta,frequency,damping)

func get_current_position():
	match type:
		TYPE_FLOAT:
			return values[0].position
		TYPE_VECTOR2:
			return Vector2(values[0].position,values[1].position)
		TYPE_VECTOR3:
			return Vector3(values[0].position,values[1].position,values[2].position)
		TYPE_VECTOR4:
			return Vector4(values[0].position,values[1].position,values[2].position,values[3].position);

func set_current_value(newValue):
	if type != typeof(newValue):
		print("Spring: set_current_value: type mismatch")
		return
	match type:
		TYPE_FLOAT:
			values[0].position = newValue
		TYPE_VECTOR2:
			values[0].position = newValue.x
			values[1].position = newValue.y
		TYPE_VECTOR3:
			values[0].position = newValue.x
			values[1].position = newValue.y
			values[2].position = newValue.z
		TYPE_VECTOR4:
			values[0].position = newValue.x
			values[1].position = newValue.y
			values[2].position = newValue.z
			values[3].position = newValue.w

