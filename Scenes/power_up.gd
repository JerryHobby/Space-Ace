extends Area2D

const SPEED:float = 100

@onready var sprite_2d = $Sprite2D
@onready var sound = $Sound


var _powerup_type:GameData.POWERUP_TYPE = GameData.POWERUP_TYPE.HEALTH


# Called when the node enters the scene tree for the first time.
func _ready():
	set_powerup_type(_powerup_type)
	sprite_2d.texture = GameData.POWER_UPS[_powerup_type]
	SoundManager.play_powerup_deploy_sound(sound)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += delta * SPEED


func set_powerup_type(pu:GameData.POWERUP_TYPE) -> void:
	_powerup_type = pu


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free() # Replace with function body.


func _on_area_entered(_area):
	SignalManager.on_powerup_hit.emit(_powerup_type)
	ScoreManager.increment_score(GameData.SCORE_POWERUP)
	queue_free()


