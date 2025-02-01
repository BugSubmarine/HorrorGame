extends CharacterBody3D

const ORIGINAL_SPEED = 4.0
var speed = 4.0
var sprint_drain = 0.2
var sprint_gain = .1
var sprint_speed= 7.0
const JUMP_VELOCITY = 4.5
var sprint_slider

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	speed = ORIGINAL_SPEED
	sprint_slider = get_node("/root/" + get_tree().current_scene.name + "/UI/sprint_slider")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

func _process(delta):
	if speed == sprint_speed:
		sprint_slider.value = sprint_slider.value - sprint_drain * delta
		if sprint_slider.value == sprint_slider.min_value:
			speed = ORIGINAL_SPEED
	if speed != sprint_speed:
		if sprint_slider.value < sprint_slider.max_value:
			sprint_slider.value = sprint_slider.value + sprint_gain * delta
		if sprint_slider.value == sprint_slider.max_value:
			sprint_slider.visible = false

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backword")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed

		if Input.is_action_just_pressed("sprint"):
			sprint_slider.visible = true
			speed = sprint_speed
		if Input.is_action_just_released("sprint"):
			speed = ORIGINAL_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()
