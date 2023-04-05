@tool
extends Node3D
class_name CameraSwitcher

signal current_camera_dropdown_changed

@onready var _tree: SceneTree = get_tree()

# camera index
var _current_camera: int = 0:
	set(camera_index):
		if !Engine.is_editor_hint():
			current_camera_dropdown_changed.emit(camera_index)
		_current_camera = camera_index


func _get_property_list():
	var properties = []
	var camera_names = []
	
	var cameras = _tree.get_nodes_in_group(CameraManager.CAMERA_GROUP)

	for i in len(cameras):
		camera_names.append(cameras[i].name + ":" + str(i))

	properties.append({
		name = "_current_camera",
		hint_string = ",".join(PackedStringArray(camera_names)),
		hint = PROPERTY_HINT_ENUM,
		type = TYPE_INT,
		usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE,
	})

	return properties


func _ready() -> void:
	if Engine.is_editor_hint():
		return
	current_camera_dropdown_changed.connect(_on_current_camera_dropdown_changed)
	_set_current_camera()


func _on_current_camera_dropdown_changed(value):
	_set_current_camera()


func _set_current_camera():
	var cameras = CameraManager.get_cameras()
	if _current_camera >= 0 and _current_camera < len(cameras):
		CameraManager.set_current_camera(cameras[_current_camera])




