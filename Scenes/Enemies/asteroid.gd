extends PathFollow2D

@onready var sprite_2d = $Area2D/Sprite2D
@onready var health_bar = $HealthBar
@onready var booms = $Booms

const BOOM_DELAY:float = 0.10

@export var low_speed = 0.05
@export var high_speed = 0.15

var _dead = false
var _speed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	_speed = randf_range(low_speed, high_speed)
	progress = 0.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !_dead:
		progress_ratio += _speed * delta


func set_sprite(s:Texture):
	sprite_2d.texture = s


func hide_health() -> void:
	health_bar.hide()


func _on_area_2d_area_entered(area):
	health_bar.take_damage(10) # Replace with function body.
	ScoreManager.increment_score(1)

func die() -> void:
	_dead = true
	ScoreManager.increment_score(GameData.SCORE_ASTEROID)
	make_powerup()
	await make_booms()
	set_process(false)
	queue_free()


func make_powerup() -> void:
	var pu = GameData.POWERUP_TYPE.values().pick_random()
	ObjectMaker.create_powerup_type(global_position, pu)


# called from animation_tree
func make_booms() -> void:
	for b in booms.get_children():
		ObjectMaker.create_boom(b.global_position)
		await get_tree().create_timer(BOOM_DELAY).timeout


func _on_health_bar_died():
	health_bar.disconnect("died", _on_health_bar_died)
	die()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
