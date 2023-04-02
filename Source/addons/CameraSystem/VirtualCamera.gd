@tool
class_name VirtualCamera 
extends Node3D

signal camera_switched

@onready var _tree: SceneTree = get_tree()
@onready var _viewport: Viewport = get_viewport()
@onready var _gizmo: MeshInstance3D = $Gizmo

@export var current: bool = false:
	get:
		return current
	set(value):
		current = value
@export var _look_at: Node3D

@export_category("Transition")
@export var transition: bool = true
@export var transition_speed: float = 0.01

@export_category("Gizmo")
@export var _is_visible: bool = false
@export var _color: Color = Color(0, 0.6, 0.7)
@export var _has_depth_test = true

const CAMERA_GROUP: String = "virtual_camera"
var _last_current: bool = current
var _camera: Camera3D 
var _current_transform: Transform3D
var _gizmo_material: StandardMaterial3D = StandardMaterial3D.new()
var _gizmo_width: float = 0.35
var _gizmo_height: float = 0.2
var _gizmo_length: float = 0.45


func _ready() -> void:
	setup_gizmo()
	add_to_group(CAMERA_GROUP)

	if !Engine.is_editor_hint():
		camera_switched.connect(_on_camera_switched)
		if current and get_viewport().get_camera_3d() != null:
			_current_transform = global_transform
			get_viewport().get_camera_3d().global_transform = global_transform
	

func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint() or (_is_visible and not current):
		_draw_gizmo()
	else:
		if _last_current != current:
			camera_switched.emit(current)

		if current:
			_current_transform = _current_transform.interpolate_with(global_transform, delta * transition_speed)
			get_viewport().get_camera_3d().global_transform = _current_transform
		
	if _look_at != null:
		get_viewport().get_camera_3d().look_at(_look_at.global_transform.origin, Vector3.UP)
		print("look at")

	_last_current = current


func _on_camera_switched(is_current: bool):
	if transition:
		_current_transform = get_viewport().get_camera_3d().global_transform
	
	if is_current:
		set_other_cameras_disabled()


func set_other_cameras_disabled():
	var nodes = _tree.get_nodes_in_group(CAMERA_GROUP)
	for node in nodes:
		if not node is VirtualCamera:
			continue
		if node == self:
			continue
		(node as VirtualCamera).current = false




func _draw_gizmo() -> void:
	draw_clear()
	var width = _gizmo_width * .5
	var height = _gizmo_height * .5
	var length = _gizmo_length * .5
	draw_line(Vector3(0, 0, 0), Vector3(width, height, -length), _color)
	draw_line(Vector3(0, 0, 0), Vector3(-width, height, -length), _color)
	draw_line(Vector3(width, height, -length), Vector3(-width, height, -length), _color)
#
	draw_line(Vector3(0, 0, 0), Vector3(width, -height, -length), _color)
	draw_line(Vector3(0, 0, 0), Vector3(-width, -height, -length), _color)
	draw_line(Vector3(width, -height, -length), Vector3(-width, -height, -length), _color)
	
	draw_line(Vector3(width, height, -length), Vector3(width, -height, -length), _color)
	draw_line(Vector3(-width, height, -length), Vector3(-width, -height, -length), _color)


func setup_gizmo():
	_gizmo.mesh = ImmediateMesh.new()
	_gizmo_material.no_depth_test = !_has_depth_test
	_gizmo_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	_gizmo_material.vertex_color_use_as_albedo = true
	_gizmo_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	_gizmo.set_material_override(_gizmo_material)


func draw_line(begin_pos: Vector3, end_pos: Vector3, color: Color = Color.RED) -> void:
	_gizmo.mesh.surface_begin(Mesh.PRIMITIVE_LINES)
	_gizmo.mesh.surface_set_color(color)
	_gizmo.mesh.surface_add_vertex(begin_pos)
	_gizmo.mesh.surface_add_vertex(end_pos)
	_gizmo.mesh.surface_end()


func draw_clear():
	(_gizmo.mesh as ImmediateMesh).clear_surfaces()
