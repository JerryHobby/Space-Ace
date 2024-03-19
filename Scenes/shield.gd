extends Area2D
@onready var animation_player = $AnimationPlayer
@onready var health_bar = $HealthBar


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	print("Shield hit")
	animation_player.play("hit")
	health_bar.take_damage(20)


func _on_health_bar_died():
	queue_free()


func _on_timer_timeout():
	queue_free() # Replace with function body.
