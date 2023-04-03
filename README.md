# Dynamic Camera System for Godot 4+



## Example

```
var cameras: Array[Node] = get_tree().get_nodes_in_group("camera_dynamic")
var is_cam_dyna = camera[0] is CameraDynamic
if is_cam_dyna:
	camera[0]
```


## Properties

current 			bool
follow				NodePath
look_at				NodePath
has_transition		bool
transition_speed	float
rotation_speed		float


## Signals

camera_switched

