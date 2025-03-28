extends CharacterBody2D

@onready var fireball_scene = preload("res://scenes/fireball.tscn")
@onready var gameManager: Node = %GameManager
@onready var BossHPLabel: Label = %Label
@onready var speech_bubble: Label = $SpeechBubble

var direction = Vector2.RIGHT

var phrases = [
	"Ah, another student here to disappoint me!",
	"Go do your homework!",
	"Detention!!!",
	"ChatGPT won't save you!",
	"Wrong!",
	"I teach. I suffer.",
	"This isn't Hogwarts."
]

func _ready():
	start_talking_loop()
	fireball_loop()

func say_random_phrase():
	var phrase = phrases[randi() % phrases.size()]
	speech_bubble.text = phrase
	speech_bubble.visible = true
	
	await get_tree().create_timer(2.0).timeout
	speech_bubble.visible = false

func start_talking_loop():
	while true:
		await get_tree().create_timer(4.0).timeout
		say_random_phrase()
	
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var chase = false
var speed = 250
var health = 3

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	
	if chase == true:
		player = get_node("../SceneObjects/CharacterBody2D")
		var direction = (player.position - self.position).normalized()
		velocity.x = direction.x * speed
	else:
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
		body.jump()
		health -= 1
		get_node("Death").play()
		BossHPLabel.text = "Health: " + str(health)
		if health == 0:
			self.queue_free()
			get_tree().change_scene_to_file("res://scenes/Win.tscn")


func _on_player_collision_body_entered(body: Node2D) -> void:
	if (body.name == 'CharacterBody2D'):
		var y_delta = position.y - body.position.y
		var x_delta = body.position.x - position.x
		if(y_delta > 30):
			body.jump()
		else:
			get_node("PlayerHit").play()
			gameManager.decreaseHealth()
			body.sideJump(x_delta)

func fireball_loop():
	while true:
		await get_tree().create_timer(3.0).timeout
		shoot_fireball()

func shoot_fireball():
	get_node("Fireball").play()
	var fireball = fireball_scene.instantiate()
	fireball.position = global_position
	
	var player_node = get_node("../SceneObjects/CharacterBody2D")
	var fire_direction = (player_node.global_position - global_position).normalized()
	fireball.direction = fire_direction
	
	get_parent().add_child(fireball)
