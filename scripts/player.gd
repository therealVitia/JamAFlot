class_name Player
extends CharacterBody3D

signal hit

@onready var sprite: AnimatedSprite3D = $AnimatedSprite3D
const grav = -9.81
const SPEED = 5.0
const JUMP_VELOCITY = 4.5

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += grav * delta

	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		sprite.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		sprite.pause()
	
	if direction.x != 0:
		sprite.flip_h = direction.x < 0
	
	move_and_slide()

func _on_detection_zone_body_entered(body: Node3D) -> void:
	if body.name == "Enemy":
		hit.emit()
		AutoBus.swap.emit()


func start(pos: Vector3) -> void:
	position = pos
