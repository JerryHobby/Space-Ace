extends Area2D

var _direction:Vector2 = Vector2.UP
var _speed:float = 300.0
var _damage:int = 10


func _ready():
	pass # Replace with function body.


func setup(pos:Vector2, dir:Vector2, speed:float, dmg:int) ->void:
	_direction = dir
	#rotation = pos.angle_to_point(dir) -45
	_speed = speed
	_damage = dmg
	global_position = pos


func _process(delta):
	position += _direction * _speed * delta
	pass


func blow_up(area:Node2D) -> void:
	if area.is_in_group(GameData.GROUP_HOMING_MISSILE) == false:
		var net_position:Vector2 = global_position - area.global_position
		ObjectMaker.create_explosion(net_position, area)

	set_process(false)
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_entered(area:Node2D):
	blow_up(area)

