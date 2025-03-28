extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const SPEED = 40.0
var direction = Vector2.LEFT
var is_moving = false

func _ready():
	move_randomly()

func move_randomly():
	while true:
		var left_or_right = randi() % 2 == 0
		direction = Vector2.LEFT if randi() % 2 == 0 else Vector2.RIGHT
		
		is_moving = true
		get_node("AnimatedSprite2D").play("Jump")
		await get_tree().create_timer(1.5).timeout
		
		is_moving = false
		get_node("AnimatedSprite2D").play("Idle")
		await get_tree().create_timer(2.0).timeout

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	if is_moving:
		velocity.x = direction.x * SPEED
		move_and_slide()
	else:
		velocity.x = 0
	
	if direction.x > 0:
		get_node("AnimatedSprite2D").flip_h = true
	else:
		get_node("AnimatedSprite2D").flip_h = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		get_node("Jump").play()
		body.velocity.y = -1600
