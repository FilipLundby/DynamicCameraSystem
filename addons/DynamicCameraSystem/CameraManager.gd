extends Node

signal camera_switched

@onready var _tree: SceneTree = get_tree()
const CAMERA_GROUP: String = "camera_dynamic"

# The instance id of the node
var current_camera: int = 0 


func _ready() -> void:
	if current_camera != 0:
		return
	var cameras = get_cameras()
	if len(cameras) > 0:
		current_camera = cameras[0].get_instance_id()


func set_current_camera(node: CameraViewpoint) -> void:
	current_camera = node.get_instance_id()
	camera_switched.emit(node)


func get_current_camera() -> CameraViewpoint:
	return instance_from_id(current_camera)


func get_cameras() -> Array:
	return _tree.get_nodes_in_group(CAMERA_GROUP)




