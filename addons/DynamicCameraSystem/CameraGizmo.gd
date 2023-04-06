extends EditorNode3DGizmoPlugin


const CAMERA_DYNAMIC = preload("CameraViewpoint.gd")

var width: float = .5
var height: float = .3
var length: float = .5


func _get_gizmo_name() -> String:
	return "CameraViewpointGizmo"


func _init():
	create_material("main", Color(0, .6, .99))


func _has_gizmo(node):
	return node is CAMERA_DYNAMIC


func _redraw(gizmo):
	gizmo.clear()

	var node3d = gizmo.get_node_3d()

	var lines = PackedVector3Array()

	lines.push_back(Vector3(0, 0, 0))
	lines.push_back(Vector3(-width, height, -length))

	lines.push_back(Vector3(0, 0, 0))
	lines.push_back(Vector3(-width, -height, -length))

	lines.push_back(Vector3(0, 0, 0))
	lines.push_back(Vector3(width, -height, -length))

	lines.push_back(Vector3(0, 0, 0))
	lines.push_back(Vector3(width, height, -length))
	
	lines.push_back(Vector3(-width, height, -length))
	lines.push_back(Vector3(-width, -height, -length))
	
	lines.push_back(Vector3(-width, -height, -length))
	lines.push_back(Vector3(width, -height, -length))
	
	lines.push_back(Vector3(width, -height, -length))
	lines.push_back(Vector3(width, height, -length))
	
	lines.push_back(Vector3(width, height, -length))
	lines.push_back(Vector3(-width, height, -length))
	
	var offset = 0.125
	lines.push_back(Vector3(-width * 0.5 + offset * 2, height + offset, -length))
	lines.push_back(Vector3(-width * 0.5 + offset, height, -length))

	lines.push_back(Vector3(width * 0.5 - offset * 2, height + offset, -length))
	lines.push_back(Vector3(width * 0.5 - offset, height, -length))
	
	gizmo.add_lines(lines, get_material("main", gizmo), false)
