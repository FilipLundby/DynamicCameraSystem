@tool
extends EditorPlugin

const CameraGizmo = preload("CameraGizmo.gd")

var gizmo_plugin = CameraGizmo.new()



func _enter_tree():
	add_custom_type("CameraDynamic", "Node3D", preload("CameraDynamic.gd"), preload("CameraDynamic.svg"))
	add_node_3d_gizmo_plugin(gizmo_plugin)


func _exit_tree():
	remove_custom_type("CameraDynamic")
	remove_node_3d_gizmo_plugin(gizmo_plugin)

