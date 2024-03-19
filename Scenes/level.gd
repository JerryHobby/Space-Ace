extends Node2D

@onready var music = $music

@onready var power_up = $PowerUp
@onready var power_up_2 = $PowerUp2

func _ready():
	if GameManager.music():
		music.play()


func _process(delta):
	if Input.is_action_just_pressed("quit"):
		GameManager.load_main_scene()
		
	if Input.is_action_just_pressed("music"):
		GameManager.toggle_music()
		play_music()

	if Input.is_action_just_pressed("sounds"):
		GameManager.toggle_sounds()

	if Input.is_action_pressed("shoot"):
		pass


func play_music():
	if GameManager.music():
		music.play()
	else:
		music.stop()

