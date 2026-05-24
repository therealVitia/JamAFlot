extends Node3D

@onready var body: RigidBody3D = $RigidBody3D
@onready var collision: CollisionShape3D = $RigidBody3D/CollisionShape3D
@onready var anim: AnimatedSprite3D = $AnimatedSprite3D
@export var type_shape: int = 0
@export var type_voice: int = 0
var isWorld: bool = true

func _ready() -> void:
	type_shape = type_shape % 5
	type_voice = type_voice % 6
	AutoBus.swap.connect(switch)
	_enable_all()
	$Label3D.hide()

func switch() -> void:
	if isWorld:
		_disable_all()
	else:
		_enable_all()

func _disable_all() -> void:
	collision.disabled = true
	anim.stop()
	anim.visible = false
	body.freeze = true
	isWorld = false

func _enable_all() -> void:
	match type_shape:
		1: anim.play("Bnpc1")
		2: anim.play("Bnpc2")
		3: anim.play("Bnpc3")
		4: anim.play("Bnpc4")
		_: pass
	anim.visible = true
	collision.disabled = false
	body.freeze = false
	isWorld = true


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Player" and type_voice != 0 and isWorld:
		$Label3D.show()
		message()

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		$Label3D.hide()

func message() -> void:
	var count_collectible: int = get_tree().get_nodes_in_group("collectible").size()
	if type_voice == 1:
		if count_collectible > 3:
			$Label3D.text = "Ils savent..."
		else:
			$Label3D.text = "Ils veulent te voir."
	if type_voice == 2:
		if count_collectible > 3:
			$Label3D.text = "Cache toi !"
		else:
			$Label3D.text = "On t'attent..."
	if type_voice == 3:
		if count_collectible > 3:
			$Label3D.text = "Tu veux ma photo ?!"
		else:
			$Label3D.text = "Tu cherche quelqu'un ?"
	if type_voice == 4:
		if count_collectible > 2:
			$Label3D.text = "Tu est bizarre..."
		else:
			$Label3D.text = "Tu es silencieuse aujourd'hui."
	if type_voice == 5:
		if count_collectible > 2:
			$Label3D.text = "Ha ha, la nulle, regardez la !"
		else:
			$Label3D.text = "..."
	if type_voice == 6:
		if count_collectible > 2:
			$Label3D.text = "Ha ha !"
		else:
			$Label3D.text = "..."
	if type_voice == 7:
		if count_collectible > 1:
			$Label3D.text = "Tu dérange !"
		else:
			$Label3D.text = "Escuse moi..."
	if type_voice == 8:
		if count_collectible > 1:
			$Label3D.text = "Dégage !"
		else:
			$Label3D.text = "J'ai peur..."
	if type_voice == 9:
		if count_collectible > 1:
			$Label3D.text = "Fuis !"
		else:
			$Label3D.text = "Je t'aime..."
	if type_voice == 10:
		if count_collectible > 0:
			$Label3D.text = "Ne bouge pas"
		else:
			$Label3D.text = "Prends ton temps..."
	
