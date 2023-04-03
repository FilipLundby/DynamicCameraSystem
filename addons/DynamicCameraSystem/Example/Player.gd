extends CharacterBody3D

@export var speed: float = 3.5

func _physics_process(_delta: float) -> void:
	var dir = Vector3()

	if Input.is_key_pressed(KEY_A):
		dir += Vector3.LEFT
	if Input.is_key_pressed(KEY_D):
		dir += Vector3.RIGHT
	if Input.is_key_pressed(KEY_W):
		dir += Vector3.FORWARD
	if Input.is_key_pressed(KEY_S):
		dir += Vector3.BACK

	dir = dir.normalized()
	velocity = dir * speed
	move_and_slide()
