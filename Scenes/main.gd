extends Node2D

@onready var music = $music
@onready var sound = $sound

@onready var music_label = $CanvasLayer/MarginContainer/CanvasLayer2/MarginContainer/MarginContainer/VBoxContainer/MusicLabel
@onready var sound_label = $CanvasLayer/MarginContainer/CanvasLayer2/MarginContainer/MarginContainer/VBoxContainer/SoundLabel


func _ready():
	set_labels()
	if GameManager.music():
		music.play()


func _process(delta):
	if Input.is_action_just_pressed("music"):
		GameManager.toggle_music()
		set_labels()
		play_music()

	if Input.is_action_just_pressed("sounds"):
		GameManager.toggle_sounds()
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


func _on_play_button_pressed():
	GameManager.load_level_scene()


func _on_exit_button_pressed():
	pass # Replace with function body.


func _on_play_button_mouse_entered():
	SoundManager.button_click(sound)


func _on_exit_button_mouse_entered():
	SoundManager.button_click(sound)
