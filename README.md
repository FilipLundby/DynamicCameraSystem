# Dynamic Camera System for Godot 4+

This plugin lets you: 

* dynamically tween between camera position
* and/or smooth follow a node of your choise
* and/or look at a node of your choise (called `watch` to avoid naming conflicts with Godots build-in method)


## Usage

1. [Install the plugin](https://docs.godotengine.org/en/stable/tutorials/plugins/editor/installing_plugins.html) and enable it through `Project Settings` -> `Plugins`.
2. Add a `Camera3D` to your scene (if you haven't already).
3. Add one or more `CameraDynamic` nodes.

You are now ready to make the `CameraDynamic` follow or look at whatever you want. See the exposed properties in the inspector.

Optionally you can also add a `CameraSwitcher` node. It lets you manually switch between cameras. Useful while testing.


## Examples

### Access cameras

```GDScript
func _ready() -> void:
	var cams: Array = CameraManager.get_cameras()
```

### Get current camera

```GDScript
func _ready() -> void:
	var current_camera: CameraDynamic = CameraManager.get_current_camera()
```

### Set a camera as current

```GDScript
func _ready() -> void:
	var cams: Array = CameraManager.get_cameras()
	CameraManager.set_current_camera(cams[0])
```

### Add and remove cameras 

```GDScript
func _ready() -> void:
	var cam = CameraDynamic.new()
	# Add
	add_child(cam)
	# Remove
	cam.queue_free()
```

### Listen for camera switching

```GDScript
func _ready() -> void:
	CameraManager.camera_switched.connect(_on_camera_switched)

func _on_camera_switched(current_camera: CameraDynamic):
	print("The current camera is: ", current_camera.name)
```


## CameraDynamic properties

```GDScript
follow		# A node the camera should follow
watch		# A node the camera should look at
has_transition	# Whether there should be a transition between the previous and the current camera 
speed_movement	# Position interpolation speed
speed_rotation	# Rotation interpolation speed
```

## CameraManager signals

```GDScript
camera_switched
```

## Ideas for improvements

* Allow non-interpolation using RemoteTransform
* Trigger areas (RE style)
* ~~Centralize enabling/disabling of cameras~~
* ~~Accessing cameras through singleton~~


## About

Hi I'm Filip and I made this. [Catch me on Twitter](https://twitter.com/skooterkurt).


## CREDITS

* videocam icon by [ionic.io](https://ionic.io/ionicons)

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
