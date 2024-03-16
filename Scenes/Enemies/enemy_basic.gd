extends PathFollow2D

@export var shoots:bool = false
@export var aims_at_player:bool = false
@export var bullet_scene: PackedScene
@export var bullet_damage: int = 10
@export var bullet_speed: float = 170.0
@export var bullet_direction: Vector2 = Vector2.DOWN
@export var bullet_wait_time: float = 3.0
@export var bullet_wait_time_var: float = 0.05
@export var gun_offset:float = 40
@export var waves = 4
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var laser_timer = $LaserTimer
@onready var booms = $Booms

var _player_ref:Player
var _speed:float = 0.0
var _can_shoot:bool = false
var _dead:bool = false
var _anim_string:String

func _ready():
	_player_ref = get_tree().get_first_node_in_group(GameData.GROUP_PLAYER)
	if !_player_ref:
		queue_free()
	animated_sprite_2d.play(_anim_string)


func setup(speed:float, anim_name:String) -> void:
	_speed = speed
	_anim_string = anim_name


func _process(delta):
	progress_ratio += _speed * delta
	if progress_ratio > 0.99:
		queue_free()


func start_shoot_timer() -> void:
	Utils.set_and_start_time(
		laser_timer, 
		bullet_wait_time, 
		bullet_wait_time_var )



func update_bullet_direction() -> void:
	if aims_at_player == false \
	or is_instance_valid(_player_ref) == false:
		return
	
	bullet_direction = global_position.direction_to(_player_ref.global_position)


func shoot() -> void:
	var bullet = bullet_scene.instantiate()

	var net_position:Vector2 = global_position
	net_position.y += gun_offset * bullet_direction.y
	
	update_bullet_direction()

	bullet.setup(
		net_position,
		bullet_direction,
		bullet_speed,
		bullet_damage )
	
	get_tree().root.add_child(bullet)
	start_shoot_timer()


func _on_laser_timer_timeout():
	shoot()


func _on_visible_on_screen_notifier_2d_screen_entered():
	if shoots:
		start_shoot_timer()


func _on_visible_on_screen_notifier_2d_screen_exited():
	set_process(false)
	queue_free()


func _on_area_2d_area_entered(area):
	pass
