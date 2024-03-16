
class_name Utils

static func set_and_start_time(
	timer:Timer, 
	target:float, 
	variance: float) -> void:
	
	var r_low = target - variance
	var r_high = target + variance

	timer.wait_time = randf_range(r_low, r_high)
	timer.start()

