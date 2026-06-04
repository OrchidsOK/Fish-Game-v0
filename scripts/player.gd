extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const GRAVITY = 9.8
const MOUSE_SENSITIVITY = 0.003
const CAM_DISTANCE = 5.0
const CAM_HEIGHT = 2.0

var cam_angle = 0.0
var cam_yaw = 0.0
var is_paused = false
@onready var camera = $Camera3D

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	var config = ConfigFile.new()
	config.load("user://settings.cfg")

	
	config.load("user://settings.cfg")
	var skin_color = config.get_value("character", "skin_color", Color(1.0, 0.8, 0.6))
	var clothes_color = config.get_value("character", "clothes_color", Color(0.2, 0.4, 0.8))

	$Body.get_active_material(0).albedo_color = clothes_color
	$ArmLeft.get_active_material(0).albedo_color = clothes_color
	$ArmRight.get_active_material(0).albedo_color = clothes_color
	$Head.get_active_material(0).albedo_color = skin_color
	$HandLeft.get_active_material(0).albedo_color = skin_color
	$HandRight.get_active_material(0).albedo_color = skin_color
	
func _input(event):
	if event is InputEventMouseMotion:
		cam_yaw -= event.relative.x * MOUSE_SENSITIVITY
		cam_angle -= event.relative.y * MOUSE_SENSITIVITY
		cam_angle = clamp(cam_angle, -0.8, 0.5)
	if event.is_action_pressed("ui_cancel"):
		if is_paused:
			return
		is_paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		var pause_menu = preload("res://scenes/pause_menu.tscn").instantiate()
		pause_menu.connect("closing", _on_pause_closed)
		get_tree().root.add_child(pause_menu)
		get_tree().paused = true
			
func _on_pause_closed():
	is_paused = false
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
		
	if direction != Vector3.ZERO:
		var target_angle = atan2(direction.x, direction.z) + PI
		rotation.y = lerp_angle(rotation.y, target_angle, 0.2)
	move_and_slide()

	# update camera position
	var cam_offset = Vector3(
		sin(cam_yaw) * CAM_DISTANCE,
		CAM_HEIGHT + sin(cam_angle) * CAM_DISTANCE,
		cos(cam_yaw) * CAM_DISTANCE
	)
	camera.global_position = global_position + cam_offset
	camera.look_at(global_position + Vector3(0, 1, 0), Vector3.UP)
