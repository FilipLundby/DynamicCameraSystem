@tool
extends MeshInstance3D

@onready var _parent = get_parent()

@export_category("Gizmo")
@export var _is_visible: bool = false
@export var _has_depth_test = true
@export var _color: Color = Color(0, 0.85, 0.99)
@export var _color_top: Color = Color(1, 0, 0)

var _gizmo_material: StandardMaterial3D = StandardMaterial3D.new()
var _gizmo_width: float = 0.35
var _gizmo_height: float = 0.2
var _gizmo_length: float = 0.45


func _ready() -> void:
	_setup_gizmo()


func _process(delta: float) -> void:
	draw_clear()
	if Engine.is_editor_hint() or !_parent.current:
		_draw_gizmo()


func _draw_gizmo() -> void:
	var width = _gizmo_width * .5
	var height = _gizmo_height * .5
	var length = _gizmo_length * .5
	draw_line(Vector3(0, 0, 0), Vector3(width, height, -length), _color)
	draw_line(Vector3(0, 0, 0), Vector3(-width, height, -length), _color)
	draw_line(Vector3(width, height, -length), Vector3(-width, height, -length), _color_top)

	draw_line(Vector3(0, 0, 0), Vector3(width, -height, -length), _color)
	draw_line(Vector3(0, 0, 0), Vector3(-width, -height, -length), _color)
	draw_line(Vector3(width, -height, -length), Vector3(-width, -height, -length), _color)
	
	draw_line(Vector3(width, height, -length), Vector3(width, -height, -length), _color)
	draw_line(Vector3(-width, height, -length), Vector3(-width, -height, -length), _color)


func _setup_gizmo():
	mesh = ImmediateMesh.new()
	_gizmo_material.no_depth_test = !_has_depth_test
	_gizmo_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	_gizmo_material.vertex_color_use_as_albedo = true
	_gizmo_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	set_material_override(_gizmo_material)


func draw_line(begin_pos: Vector3, end_pos: Vector3, color: Color = Color.RED) -> void:
	mesh.surface_begin(Mesh.PRIMITIVE_LINES)
	mesh.surface_set_color(color)
	mesh.surface_add_vertex(begin_pos)
	mesh.surface_add_vertex(end_pos)
	mesh.surface_end()


func draw_clear():
	(mesh as ImmediateMesh).clear_surfaces()
