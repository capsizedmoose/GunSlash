class_name SpringMotion

const epsilon = 0.0001;

class DampedSpringMotionParams:
	var posPosCoef: float
	var posVelCoef: float
	var velPosCoef: float
	var velVelCoef: float

static func _CalcDampedSpringMotionParams(delta_time:float,angular_frequency:float,damping_ratio:float) -> DampedSpringMotionParams:
	var params =  DampedSpringMotionParams.new()
	
	if damping_ratio < 0:
		damping_ratio = 0
	if angular_frequency < 0: 
		angular_frequency = 0

	if angular_frequency < epsilon:
		params.posPosCoef = 1;
		params.posVelCoef = 0;
		params.velPosCoef = 0;
		params.velVelCoef = 1;
		return params;

	if damping_ratio > 1 + epsilon:
		# over-damped
		var za = -angular_frequency * damping_ratio;
		var zb = angular_frequency * sqrt(damping_ratio * damping_ratio - 1);
		var z1 = za - zb;
		var z2 = za + zb;
		# Value e (2.7) raised to a specific power
		var e1 = exp(z1 * delta_time);
		var e2 = exp(z2 * delta_time);
		var invTwoZb = 1 / (2 * zb);
		var e1_Over_TwoZb = e1 * invTwoZb;
		var e2_Over_TwoZb = e2 * invTwoZb;
		var z1e1_Over_TwoZb = z1 * e1_Over_TwoZb;
		var z2e2_Over_TwoZb = z2 * e2_Over_TwoZb;
		params.posPosCoef = e1_Over_TwoZb * z2 - z2e2_Over_TwoZb + e2;
		params.posVelCoef = -e1_Over_TwoZb + e2_Over_TwoZb;
		params.velPosCoef = (z1e1_Over_TwoZb - z2e2_Over_TwoZb + e2) * z2;
		params.velVelCoef = -z1e1_Over_TwoZb + z2e2_Over_TwoZb;
	elif damping_ratio < 1 - epsilon:
		# under-damped
		var omegaZeta = angular_frequency * damping_ratio;
		var alpha = angular_frequency * sqrt(1 - damping_ratio * damping_ratio);
		var expTerm = exp(-omegaZeta * delta_time);
		var cosTerm = cos(alpha * delta_time);
		var sinTerm = sin(alpha * delta_time);
		var invAlpha = 1 / alpha;
		var expSin = expTerm * sinTerm;
		var expCos = expTerm * cosTerm;
		var expOmegaZetaSin_Over_Alpha = expTerm * omegaZeta * sinTerm * invAlpha;
		params.posPosCoef = expCos + expOmegaZetaSin_Over_Alpha;
		params.posVelCoef = expSin * invAlpha;
		params.velPosCoef = -expSin * alpha - omegaZeta * expOmegaZetaSin_Over_Alpha;
		params.velVelCoef = expCos - expOmegaZetaSin_Over_Alpha;
	else:
		# critically damped
		var expTerm = exp(-angular_frequency * delta_time);
		var timeExp = delta_time * expTerm;
		var timeExpFreq = timeExp * angular_frequency;
		params.posPosCoef = timeExpFreq + expTerm;
		params.posVelCoef = timeExp;
		params.velPosCoef = -angular_frequency * timeExpFreq;
		params.velVelCoef = -timeExpFreq + expTerm;
	return params;

static func _UpdateDampedSpringMotion(data:SpringData,equilibriumPos:float,parameters:DampedSpringMotionParams):	
	var oldPos = data.position - equilibriumPos;
	var oldVel = data.velocity;
	data.position = oldPos * parameters.posPosCoef + oldVel * parameters.posVelCoef + equilibriumPos;
	data.velocity = oldPos * parameters.velPosCoef + oldVel * parameters.velVelCoef;

static func CalcDampedSimpleHarmonicMotion(data:SpringData,equilibriumPosition:float,delta:float,angularFrequency:float,dampingRatio:float):
			var motionParams = _CalcDampedSpringMotionParams(delta, angularFrequency, dampingRatio);
			_UpdateDampedSpringMotion(data, equilibriumPosition, motionParams);
