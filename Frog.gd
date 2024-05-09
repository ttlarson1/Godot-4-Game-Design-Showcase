extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var chase = false
var SPEED = 50
var busy = false

func _ready():
	get_node("AnimatedSprite2D").play("Idle")

func _physics_process(delta):
	velocity.y += gravity * delta
	if  not get_node("AnimatedSprite2D").animation == "Death":
		if chase == true:
			if not get_node("AnimatedSprite2D").animation == "Death":
				get_node("AnimatedSprite2D").play("Jump")
				player = get_node("../../Player")
				var direction = (player.position - self.position).normalized()
				if direction.x > 0:
					get_node("AnimatedSprite2D").flip_h = true
					velocity.x = direction.x + SPEED
				else:
					get_node("AnimatedSprite2D").flip_h = false
					velocity.x = -(direction.x + SPEED)
		else:
			if not get_node("AnimatedSprite2D").animation == "Death":
				get_node("AnimatedSprite2D").play("Idle")
				velocity.x = 0
	move_and_slide()
	
func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true


func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false


func _on_player_death_body_entered(body):
	if body.name == "Player":
		death()

func _on_player_collision_body_entered(body):
	if body.name == "Player" and not busy:
		Game.playerHP -= 3
		death()
		
func death():
	Game.Gold += 1
	Utils.saveGame()
	busy = true
	get_node("AnimatedSprite2D").play("Death")
	chase = false
	await get_node("AnimatedSprite2D").animation_finished
	self.queue_free()
