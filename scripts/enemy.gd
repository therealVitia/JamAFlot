extends CharacterBody3D

@export var target: CharacterBody3D
@export var environment: Node3D
@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
@onready var sprite: Sprite3D = $Sprite3D

const GRAVITY: float = -9.8
var speed: float = 0.0
var navigation_mesh: NavigationRegion3D

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	navigation_agent.target_position = target.global_position

	var destination: Vector3 = navigation_agent.get_next_path_position() - global_position
	var direction: Vector3 = destination.normalized()

	speed = target.SPEED * 1.1
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed

	if direction.x != 0:
		sprite.flip_h = direction.x < 0

	move_and_slide()
