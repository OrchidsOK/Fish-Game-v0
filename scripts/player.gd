extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const GRAVITY = 9.8
const MOUSE_SENSITIVITY = 0.003
const CAM_DISTANCE = 5.0
const CAM_HEIGHT = 2.0

var cam_angle = 0.0
var cam_yaw = 0.0

@onready var camera = $Camera3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	var config = ConfigFile.new()
	config.load("user://settings.cfg")
	var player_color = config.get_value("settings", "player_color", Color.WHITE)
	$MeshInstance3D.get_active_material(0).albedo_color = player_color

func _input(event):
	if event is InputEventMouseMotion:
		cam_yaw -= event.relative.x * MOUSE_SENSITIVITY
		cam_angle -= event.relative.y * MOUSE_SENSITIVITY
		cam_angle = clamp(cam_angle, -0.8, 0.5)
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= GRAVITY * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var forward = Vector3(-sin(cam_yaw), 0, -cos(cam_yaw))
	var right = Vector3(cos(cam_yaw), 0, -sin(cam_yaw))
	var direction = Vector3.ZERO

	if Input.is_key_pressed(KEY_W):
		direction += forward
	if Input.is_key_pressed(KEY_S):
		direction -= forward
	if Input.is_key_pressed(KEY_A):
		direction -= right
	if Input.is_key_pressed(KEY_D):
		direction += right

	if direction != Vector3.ZERO:
		direction = direction.normalized()
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

	# update camera position
	var cam_offset = Vector3(
		sin(cam_yaw) * CAM_DISTANCE,
		CAM_HEIGHT + sin(cam_angle) * CAM_DISTANCE,
		cos(cam_yaw) * CAM_DISTANCE
	)
	camera.global_position = global_position + cam_offset
	camera.look_at(global_position + Vector3(0, 1, 0), Vector3.UP)
