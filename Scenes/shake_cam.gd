extends Camera2D

@onready var timer = $Timer

const SHAKE_RANGE:Vector2 = Vector2(-5.0, 5.0)

var _shake_offset:Vector2 = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	_shake_offset = offset
	set_process(false)
	SignalManager.on_player_hit.connect(on_player_hit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	offset = Vector2 (
		_shake_offset.x + get_random_shake(),
		_shake_offset.y + get_random_shake()
	)


func get_random_shake() -> float:
	return randf_range(SHAKE_RANGE.x, SHAKE_RANGE.y)
	

func on_player_hit(_v:int) -> void:
	if GameManager.god_mode():
		return

	set_process(true)
	timer.start()
	

func _on_timer_timeout():
	set_process(false)
	offset = _shake_offset


