extends CharacterBody3D

@export var target: CharacterBody3D
@export var environment: Node3D
@export var timer := 5

@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D

@onready var hard_shadow: Node3D     = $HardShadow
@onready var fake_shadow: AnimatedSprite3D     = $fakeShadow
@onready var real_shadow: AnimatedSprite3D     = $realShadow
@onready var little_step: AnimatedSprite3D     = $littleStep
@onready var audio_little_step: AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var collision: CollisionShape3D = $CollisionShape3D

var sprite: AnimatedSprite3D
const GRAVITY: float = -9.8
var speed: float = 0.0
@export var speed_ratio: float = 1.1
var navigation_mesh: NavigationRegion3D
var is_imaginary_world: bool = false
var current_collectible_count: int = 0

func _ready() -> void:
	_disable_enemy()
	AutoBus.collectible_found.connect(_on_collectible_found)
	AutoBus.swap.connect(_on_swap)

func _on_swap() -> void:
	if is_imaginary_world:
		is_imaginary_world = false
		_disable_enemy()
	else:
		is_imaginary_world = true
		_spawn_near_player()

func _spawn_near_player() -> void:
	global_position = target.global_position
	navigation_agent.set_navigation_map(get_world_3d().navigation_map)
	await get_tree().create_timer(timer).timeout
	if is_imaginary_world:
		_enable_enemy()

func _enable_enemy() -> void:
	collision.disabled = false
	navigation_agent.avoidance_enabled = true
	set_physics_process(true)
	_set_form(current_collectible_count)
	audio_little_step.play(0.0)

func _disable_enemy() -> void:
	collision.disabled = true
	navigation_agent.avoidance_enabled = false
	set_physics_process(false)
	velocity = Vector3.ZERO
	hard_shadow.visible = false
	fake_shadow.visible = false
	real_shadow.visible = false
	little_step.visible = false
	audio_little_step.stop()



func _on_collectible_found() -> void:
	current_collectible_count += 1
	if is_imaginary_world:
		_disable_enemy()
		AutoBus.swap.emit()

func _set_form(count: int) -> void:
	hard_shadow.visible = false
	fake_shadow.visible = false
	fake_shadow.pause()
	real_shadow.visible = false
	real_shadow.pause()
	little_step.visible = false
	little_step.pause()
	match count:
		0:
			pass
		1:
			little_step.visible = true
			audio_little_step.play()
			little_step.play("default")
			sprite = little_step
		2:
			hard_shadow.visible = true
			sprite = null
		3:
			fake_shadow.visible = true
			fake_shadow.play("default")
			sprite = fake_shadow
		4:
			real_shadow.visible = true
			real_shadow.play("default")
			sprite = real_shadow
		_:
			real_shadow.visible = true
			real_shadow.play("default")
			sprite = real_shadow

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	navigation_agent.target_position = target.global_position

	var destination: Vector3 = navigation_agent.get_next_path_position() - global_position
	var direction: Vector3 = destination.normalized()

	speed = target.SPEED * 1.1
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	if direction.x != 0 and sprite:
		sprite.flip_h = direction.x < 0

	move_and_slide()
