extends Node2D

@onready var music = $music
@onready var sound = $sound

@onready var music_label = $CanvasLayer/MarginContainer/CanvasLayer2/MarginContainer/MarginContainer/VBoxContainer/MusicLabel
@onready var sound_label = $CanvasLayer/MarginContainer/CanvasLayer2/MarginContainer/MarginContainer/VBoxContainer/SoundLabel
@onready var god_mode_label = $CanvasLayer/MarginContainer/CanvasLayer2/MarginContainer/MarginContainer/VBoxContainer/GodModeLabel
@onready var high_score_label = $CanvasLayer/MarginContainer/CanvasLayer/MarginContainer/HBoxContainer/HighScoreLabel



func _ready():
	set_labels()
	if GameManager.music():
		music.play()


func _process(_delta):
	if Input.is_action_just_pressed("music"):
		GameManager.toggle_music()
		set_labels()
		play_music()

	if Input.is_action_just_pressed("sounds"):
		GameManager.toggle_sounds()
		set_labels()

	if Input.is_action_just_pressed("god_mode"):
		GameManager.toggle_god_mode()
		set_labels()

	if Input.is_action_just_pressed("pause"):
		GameManager.load_level_scene()

	if Input.is_action_just_pressed("reset_hs"):
		DataStorage.reset_high_score()
		set_labels()


func play_music():
	if GameManager.music():
		music.play()
	else:
		music.stop()


func set_labels():
	if GameManager.music():
		music_label.text = "(M)usic on"
	else:
		music_label.text = "(M)usic off"

	if GameManager.sounds():
		sound_label.text = "(S)ounds on"
	else:
		sound_label.text = "(S)ounds off"

	if GameManager.god_mode():
		god_mode_label.text = "(G)odMode on"
	else:
		god_mode_label.text = "(G)odMode off"

	high_score_label.text = ScoreManager.get_high_score_formatted()


func _on_play_button_pressed():
	GameManager.load_level_scene()


func _on_exit_button_pressed():
	get_tree().quit()


func _on_play_button_mouse_entered():
	SoundManager.button_click(sound)


func _on_exit_button_mouse_entered():
	SoundManager.button_click(sound)
