extends CharacterBody2D

@onready var gameManager: Node = %GameManager

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var chase = false
var speed = 100

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	
	if chase == true:
		if get_node("AnimatedSprite2D").animation != "death":
			get_node("AnimatedSprite2D").play("run")
			player = get_node("../../CharacterBody2D")
			var direction = (player.position - self.position).normalized()
			if direction.x > 0:
				get_node("AnimatedSprite2D").flip_h = true
			else:
				get_node("AnimatedSprite2D").flip_h = false
			velocity.x = direction.x * speed
	else:
		if get_node("AnimatedSprite2D").animation != "death":
			get_node("AnimatedSprite2D").play("idle")
		velocity.x = 0

	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		chase = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		chase = false

func _on_player_death_body_entered(body: Node2D) -> void:
	if body.name == "CharacterBody2D":
		get_node("AnimatedSprite2D").play("death")
		get_node("Death").play()
		body.jump()
		await get_node("AnimatedSprite2D").animation_finished
		self.queue_free()


func _on_player_collision_body_entered(body: Node2D) -> void:
	if (body.name == 'CharacterBody2D'):
		var y_delta = position.y - body.position.y
		var x_delta = body.position.x - position.x
		if(y_delta > 30):
			queue_free()
			body.jump()
		else:
			gameManager.decreaseHealth()
			get_node("PlayerHit").play()
			body.sideJump(x_delta)
