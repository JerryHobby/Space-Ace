extends Area2D
@onready var animation_player = $AnimationPlayer
@onready var health_bar = $HealthBar
@onready var timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = GameData.SHIELD_LIFE
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_area_entered(area):
	animation_player.play("hit")

	var damage:int = 0
	
	if area.is_in_group(GameData.GROUP_ENEMY_SHIP):
		damage = GameData.DAMAGE_COLLISION
		ObjectMaker.create_boom(global_position)
		
	elif area.is_in_group(GameData.GROUP_SAUCER):
		damage = GameData.DAMAGE_SAUCER_COLLISION
		ObjectMaker.create_boom(global_position)

	elif area.is_in_group(GameData.GROUP_HOMING_MISSILE):
		damage = GameData.DAMAGE_MISSILE

	elif area.is_in_group(GameData.GROUP_BULLET):
		damage = area.get_bullet_damage()

	health_bar.take_damage(damage)



func _on_health_bar_died():
	health_bar.disconnect("died", _on_health_bar_died)
	queue_free()


func _on_timer_timeout():
	queue_free() # Replace with function body.
