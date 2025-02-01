extends Control


@onready var main = $".."
@onready var resume_button = $ColorRect/MarginContainer/VBoxContainer/Resume
@onready var quit_button = $ColorRect/MarginContainer/VBoxContainer/TextureButton
#func _ready():
	#Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

@onready var pause_menu = $PauseMenu


func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()


var paused = false
# Called every frame. 'delta' is the elapsed time since the previous frame.

func pauseMenu():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if paused:
		hide()
		get_tree().paused = false
		#Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
		# Automatically hides the cursor
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		Engine.time_scale = 1
	else:
		show()
		get_tree().paused = true
		Engine.time_scale = 0
		

	paused = !paused


func _on_resume_pressed():
	pauseMenu()


func _on_quit_pressed():
	get_tree().quit()
	

