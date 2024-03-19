extends TextureProgressBar

signal died

@export var start_health:int = 100

var level_low:int = 30
var level_med:int = 65

const COLOR_DANGER:Color = Color("#cc0000")
const COLOR_MIDDLE:Color = Color("#ff9900")
const COLOR_GOOD:Color = Color("#33cc33")
const COLOR_OVER:Color = Color("#4cc9f0")

func _ready():
	max_value = start_health
	value = max_value
	level_low = start_health * 0.3
	level_med = start_health * 0.7
	set_color()


func set_color() -> void:
	if value < level_low:
		tint_progress = COLOR_DANGER
	elif value < level_med:
		tint_progress = COLOR_MIDDLE
	elif value <= max_value:
		tint_progress = COLOR_GOOD
	else:
		tint_progress = COLOR_OVER


func inc_value(v:int) -> void:
	value += v
	if value <= 0:
		died.emit()
	set_color()


func set_full_health() -> void:
	value = max_value
	set_color()


func take_damage(v:int) -> void:
	inc_value(-v)

