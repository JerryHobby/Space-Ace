extends Node2D

@onready var music = $music

func _ready():
	SignalManager.on_player_died.connect(on_player_died)
	ScoreManager.reset_score()
	if GameManager.music():
		music.play()


func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		GameManager.load_gameover_scene()
		
	if Input.is_action_just_pressed("music"):
		GameManager.toggle_music()
		play_music()

	if Input.is_action_just_pressed("sounds"):
		GameManager.toggle_sounds()

	if Input.is_action_just_pressed("god_mode"):
		GameManager.toggle_god_mode()

	if Input.is_action_pressed("shoot"):
		pass


func play_music():
	if GameManager.music():
		music.play()
	else:
		music.stop()


func on_player_died() -> void:
	for node in get_children():
		if is_instance_valid(node) and node.is_class("Node2D"):
			ObjectMaker.create_explosion(
				node.global_position, self)
			node.queue_free()

