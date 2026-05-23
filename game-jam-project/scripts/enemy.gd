extends CharacterBody3D

@export var target: CharacterBody3D
@export var speed: float = 3.5

@onready var navigation_agent = $NavigationAgent3D
@onready var sprite = $Sprite3D

const GRAVITY = -9.8

func _ready() -> void:
	navigation_agent.target_position = target.global_position

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	navigation_agent.target_position = target.global_position
	var direction = to_local(navigation_agent.get_next_path_position() - global_position)
	direction.y = 0.0
	direction = direction.normalized()

	velocity.x = direction.x * speed
	velocity.z = direction.z * speed

	if direction.x != 0:
		sprite.flip_h = direction.x < 0

	move_and_slide()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D and body.name == "Player":
		print("ennemi touche le joueur !")
