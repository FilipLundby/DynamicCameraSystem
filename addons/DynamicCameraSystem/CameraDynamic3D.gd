@tool
@icon("CameraDynamic3D.svg")
class_name CameraDynamic3D
extends Node3D

signal camera_switched

@onready var _tree: SceneTree = get_tree()
@onready var _viewport: Viewport = get_viewport()

@export var current: bool = false:
	get:
		return current
	set(value):
		current = value
@onready @export var _look_at: Node3D
@onready @export var _follow: Node3D

@export_category("Transition")
@export var has_transition: bool = true
@export var transition_speed: float = 1.0
@export var rotation_speed: float = 1.0

const CAMERA_GROUP: String = "camera_dynamic"
var _last_current: bool = current
var _camera: Camera3D 
var _current_transform: Transform3D 
var _current_position: Vector3
var _current_rotation: Vector3


func _ready() -> void:
	add_to_group(CAMERA_GROUP)
	
	if !Engine.is_editor_hint():
		_current_transform = global_transform
		camera_switched.connect(_on_camera_switched)
		if current and get_viewport().get_camera_3d() != null:
			get_viewport().get_camera_3d().global_transform = global_transform


func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	
	if _last_current != current:
		camera_switched.emit(current)
	
	if _follow != null:
		var target_transform = _follow.global_transform if _follow != null else global_transform
		_current_transform = _current_transform.interpolate_with(target_transform, delta * transition_speed)

	if current:
		var camera = get_viewport().get_camera_3d()
		camera.global_transform = _current_transform

		if _look_at != null:
			var looking_at = camera.global_transform.looking_at(_look_at.global_position, Vector3.UP)
			_current_transform = camera.global_transform.interpolate_with(looking_at, delta * rotation_speed)
		
	else:
		global_transform = _current_transform
		
		if _look_at != null:
			var looking_at = global_transform.looking_at(_look_at.global_position, Vector3.UP)
			_current_transform = global_transform.interpolate_with(looking_at, delta * rotation_speed)

	_last_current = current


func _on_camera_switched(is_current: bool):
	if has_transition:
		_current_transform = get_viewport().get_camera_3d().global_transform if is_current else global_transform
	
#	if has_transition:
#		_current_transform = get_viewport().get_camera_3d().global_transform
	
	if is_current:
		_set_other_cameras_disabled()


func _set_other_cameras_disabled():
	var nodes = _tree.get_nodes_in_group(CAMERA_GROUP)
	for node in nodes:
#		if not node is CameraDynamic:
#			continue
		if node == self:
			continue
		if not "current" in node:
			continue
		node.current = false


