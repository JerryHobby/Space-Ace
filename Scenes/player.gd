extends Area2D

class_name Player

@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var health_bar = $HealthBar
@onready var sound = $sound

@export var speed:float = 250.0
@export var bullet_scene:PackedScene
@export var bullet_speed:float = 400.0
@export var bullet_damage:int = 10
@export var bullet_direction:Vector2 = Vector2.UP

var shield_scene = preload("res://Scenes/shield.tscn")

var _shield:Node2D = null

const MARGIN:float = 32.0

var _upper_left:Vector2
var _lower_right:Vector2
var _paused:bool = false

func _ready():
	# to allow pause / resume
	process_mode = Node.PROCESS_MODE_ALWAYS
	SignalManager.pause.connect(pause)
	SignalManager.on_powerup_hit.connect(on_powerup_hit)
	set_limits()


func set_limits():
	var vp = get_viewport_rect()
	_lower_right = Vector2 (
		vp.size.x - MARGIN, 
		vp.size.y - MARGIN )
	_upper_left = Vector2 (MARGIN, MARGIN)


func _process(delta):
	
	if Input.is_action_just_pressed("pause"):
		pause()

	if _paused:
		return
		
	fly(delta)
	if Input.is_action_just_pressed("shoot"):
		shoot()


func pause():
	_paused = !_paused
	get_tree().paused = _paused


func get_input() -> Vector2:
	var v = Vector2 (
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	)
	return v.normalized()


func fly(delta) -> void:
	var v = get_input()
	animation_player.play("fly")
	sprite_2d.flip_h = true

	if v.x != 0:
		animation_player.play("turn")
		if v.x > 0:
			sprite_2d.flip_h = true
		else:
			sprite_2d.flip_h = false
	else:
		animation_player.play("fly")
	
	global_position += v * delta * speed
	global_position = global_position.clamp(_upper_left, _lower_right)


func shoot() -> void:
	var bullet = bullet_scene.instantiate()
	bullet.setup(
		global_position,
		bullet_direction,
		bullet_speed,
		bullet_damage )
	get_tree().root.add_child(bullet)


func _on_area_entered(area):

	var damage:int = 0
	
	if area.is_in_group(GameData.GROUP_ENEMY_SHIP):
		damage = GameData.DAMAGE_COLLISION
		ObjectMaker.create_boom(global_position)
		
	elif area.is_in_group(GameData.GROUP_SAUCER):
		damage = GameData.DAMAGE_SAUCER_COLLISION
		ObjectMaker.create_boom(global_position)

	elif area.is_in_group(GameData.GROUP_ASTEROID):
		damage = GameData.DAMAGE_ASTEROID_COLLISION
		ObjectMaker.create_boom(global_position)

	elif area.is_in_group(GameData.GROUP_HOMING_MISSILE):
		damage = GameData.DAMAGE_MISSILE

	elif area.is_in_group(GameData.GROUP_BULLET):
		damage = area.get_bullet_damage()

	else:
		print("Unrecognized collision")
		pause()

	SignalManager.on_player_hit.emit(damage)
	health_bar.take_damage(damage)


func add_shield():
	if is_instance_valid(_shield):
		#refresh new shield
		_shield.queue_free()

	_shield = shield_scene.instantiate()
	call_deferred("add_child", _shield)


func on_powerup_hit(powerup:GameData.POWERUP_TYPE) -> void:
	SoundManager.play_power_up_sound(powerup, sound)
	
	if powerup == GameData.POWERUP_TYPE.HEALTH:
		health_bar.inc_value(GameData.HEALTH_BONUS)
		SignalManager.on_health_bonus.emit(GameData.HEALTH_BONUS)
		
	if powerup == GameData.POWERUP_TYPE.SHIELD:
		add_shield()


func _on_health_bar_died():
	health_bar.disconnect("died", _on_health_bar_died)
	ObjectMaker.create_boom(global_position)
