extends Button

var _cameras: Array[Node]
var _index = 0


func _ready() -> void:
	_cameras = get_tree().get_nodes_in_group("camera_dynamic")
	button_up.connect(_on_button_up)


func _on_button_up() -> void:
	if _index + 1 >= len(_cameras):
		_index = 0
	else:	
		_index += 1
	if _cameras[_index] is CameraDynamic:
		_cameras[_index].current = true
	
