@tool
extends EditorPlugin

const CameraGizmo = preload("CameraGizmo.gd")
const AUTOLOAD_NAME = "CameraManager"
var gizmo_plugin = CameraGizmo.new()


func _enter_tree():
	add_custom_type("CameraViewpoint", "Node3D", preload("CameraViewpoint.gd"), preload("DynamicCameraSystem.svg"))
	add_autoload_singleton(AUTOLOAD_NAME, "res://addons/DynamicCameraSystem/CameraManager.gd")
	add_node_3d_gizmo_plugin(gizmo_plugin)


func _exit_tree():
	remove_custom_type("CameraViewpoint")
	remove_autoload_singleton(AUTOLOAD_NAME)
	remove_node_3d_gizmo_plugin(gizmo_plugin)


