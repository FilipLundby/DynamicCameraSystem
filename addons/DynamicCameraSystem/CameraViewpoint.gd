@tool
@icon("DynamicCameraSystem.svg")
class_name CameraViewpoint
extends Node3D

signal camera_switched

@onready var _tree: SceneTree = get_tree()
@onready var _viewport: Viewport = get_viewport()

@onready @export var watch: Node3D
@onready @export var follow: Node3D

@export_category("Transition")
@export var has_transition: bool = true
@export var speed_movement: float = 1.0
@export var speed_rotation: float = 1.0

var _camera: Camera3D 
var _current_transform: Transform3D 
var _current_position: Vector3
var _current_rotation: Vector3


func _enter_tree() -> void:
	add_to_group(CameraManager.CAMERA_GROUP, true)


func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	_camera = _viewport.get_camera_3d()
	_current_transform = global_transform
	CameraManager.camera_switched.connect(_on_camera_switched)
	if is_current() and _camera != null:
		_camera.global_transform = global_transform


func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	
	if follow != null:
		top_level = true
	
	var target_transform = follow.global_transform if follow != null else global_transform
	_current_transform.origin = _current_transform.origin.lerp(target_transform.origin, delta * speed_movement)

	if watch != null:
		var looking_at = _current_transform.looking_at(watch.global_position, Vector3.UP)
		_current_transform = _current_transform.interpolate_with(looking_at, delta * speed_rotation)
		
	if is_current():
		_camera.global_transform = _current_transform
	else:
		global_transform = _current_transform


func _on_camera_switched(node):
	if self != node:
		return

	if has_transition:
		_current_transform = _camera.global_transform


func is_current():
	return CameraManager.current_camera == get_instance_id()
