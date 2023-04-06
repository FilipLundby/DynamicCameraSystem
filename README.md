# Dynamic Camera System for Godot 4+

This plugin lets you: 

* dynamically tween between camera position
* and/or smooth follow a node of your choise
* and/or look at a node of your choise (called `watch` to avoid naming conflicts with Godots built-in method)

Here an example where the camera follows and looks at the player, then changes position when the player enters the car:


https://user-images.githubusercontent.com/9482792/230415669-416aa94c-1505-489f-a837-964c5ea4f2fe.mp4

<sub>Models by [@quaternius](https://twitter.com/quaternius) and [@kenneynl](https://twitter.com/KenneyNL).</sub>


## Usage

1. [Install the plugin](https://docs.godotengine.org/en/stable/tutorials/plugins/editor/installing_plugins.html) and enable it through `Project Settings` -> `Plugins`.
2. Add a `Camera3D` to your scene (if you haven't already).
3. Add one or more `CameraViewpoint` nodes.

You are now ready to make the `CameraViewpoint` follow or look at whatever you want. See the exposed properties in the inspector.

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
	var current_camera: CameraViewpoint = CameraManager.get_current_camera()
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
	var cam = CameraViewpoint.new()
	# Add
	add_child(cam)
	# Remove
	cam.queue_free()
```

### Listen for camera switching

```GDScript
func _ready() -> void:
	CameraManager.camera_switched.connect(_on_camera_switched)

func _on_camera_switched(current_camera: CameraViewpoint):
	print("The current camera is: ", current_camera.name)
```


## CameraViewpoint properties

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

## Troubleshooting

* If you see something like the below error, the CameraManger autoload may have been removed. Try disabling and enabling the Dyanmic Camera System under the plugins tab.
	```
	Parse Error: Identifier "CameraManager" not declared in the current scope.
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
