# Dynamic Camera System for Godot 4+

This plugin lets you: 

* dynamically tween between camera position
* smooth follow a node of your choise
* and/or look at a node of your choise (called `watch` to avoid naming conflicts with Godots build-in method)


## Usage

1. [Install the plugin](https://docs.godotengine.org/en/stable/tutorials/plugins/editor/installing_plugins.html) and enable it through `Project Settings` -> `Plugins`.
2. Add a `Camera3D` to your scene (if you haven't already).
3. Add one or more `CameraDynamic3D` nodes.
4. Place the `CameraDynamic3D` at the root level of your scene tree.
5. Tick the `current` checkbox on `CameraDynamic3D`*. 

You are now ready to make the camera follow or look at whatever you want.

*If you've got multiple `CameraDynamic3D` in your scene, make sure only one is 
checked. Setting a camera as `current` at runtime will automatically disable 
all the others.


## Examples

### Access cameras through groups

```GDScript
func _ready() -> void:
	var dyna_cams: Array[Node] = get_tree().get_nodes_in_group("camera_dynamic")
	var is_cam_dyna = dyna_cams[0] is CameraDynamic
	if is_cam_dyna:
		dyna_cams[0].look_at
```

### Listen for camera switching

```GDScript
func _ready() -> void:
	var dyna_cams: Array[Node] = get_tree().get_nodes_in_group("camera_dynamic")
	dyna_cams[0].camera_switched.connect(_on_camera_switched)

func _on_camera_switched(is_current: bool):
	print("Is this the current camera: ", is_current)
```

## Properties

```GDScript
current 		# bool
follow			# NodePath
watch			# NodePath
has_transition		# bool
speed_movement		# float
speed_rotation		# float
```

## Signals

```GDScript
camera_switched
```

## Ideas for improvements

* Centralize enabling/disabling of cameras
* Allow non-interpolation using RemoteTransform
* Accessing cameras through singleton


## About

Hi I'm Filip and I made this. [Catch me on Twitter](https://twitter.com/skooterkurt).


## MIT License

Copyright (c) 2023 Filip Lundby

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
