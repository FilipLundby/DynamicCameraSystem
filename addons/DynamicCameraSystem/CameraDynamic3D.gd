@tool
@icon("CameraDynamic3D.svg")
class_name CameraDynamic3D
extends Node3D

signal camera_switched

@onready var _tree: SceneTree = get_tree()
@onready var _viewport: Viewport = get_viewport()

@export var current: bool = false
@onready @export var watch: Node3D
@onready @export var follow: Node3D

@export_category("Transition")
@export var has_transition: bool = true
@export var speed_movement: float = 1.0
@export var speed_rotation: float = 1.0

const CAMERA_GROUP: String = "camera_dynamic"
var _last_current: bool = current
var _camera: Camera3D 
var _current_transform: Transform3D 
var _current_position: Vector3
var _current_rotation: Vector3


func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	add_to_group(CAMERA_GROUP)
	_camera = _viewport.get_camera_3d()
	_current_transform = global_transform
	camera_switched.connect(_on_camera_switched)
	if current and _camera != null:
		_camera.global_transform = global_transform


func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	
	if _last_current != current:
		camera_switched.emit(current)
	
	var target_transform = follow.global_transform if follow != null else global_transform
	_current_transform = _current_transform.interpolate_with(target_transform, delta * speed_movement)

	if watch != null:
		var looking_at = _current_transform.looking_at(watch.global_position, Vector3.UP)
		_current_transform = _current_transform.interpolate_with(looking_at, delta * speed_rotation)
		
	if current:
		_camera.global_transform = _current_transform
	else:
		global_transform = _current_transform

	_last_current = current


func _on_camera_switched(is_current: bool):
	if !is_current:
		return
	_set_other_cameras_disabled()

	if has_transition:
		_current_transform = _camera.global_transform 


func _set_other_cameras_disabled():
	var nodes = _tree.get_nodes_in_group(CAMERA_GROUP)
	for node in nodes:
		if not node is CameraDynamic3D:
			continue
		if node == self:
			continue
		node.current = false


