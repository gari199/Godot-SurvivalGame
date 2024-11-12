extends CharacterBody2D

var speed = 100
var player_state

@export var inv: Inv

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction.x == 0 and direction.y == 0:
		player_state = "idle"
	elif direction.x != 0 or direction.y != 0:
		player_state = "walking"

	velocity = direction * speed
	move_and_slide()
	
	play_animation(direction)
	
func play_animation(dir):
	#Decide wether is moving or idle
	if player_state == "idle":
		animated_sprite.play("idle")
		
	#Basic 4 movements. Y axis works revert?
	if player_state == "walking":
		if dir.y == -1:
			animated_sprite.play("n-walk")
		if dir.x == 1:
			animated_sprite.play("e-walk")
		if dir.y == 1:
			animated_sprite.play("s-walk")	
		if dir.x == -1:
			animated_sprite.play("w-walk")
			
	#Diagonal moves
		if dir.x > 0.5 and dir.y < -0.5:
			animated_sprite.play("ne-walk")
		if dir.x > 0.5 and dir.y > 0.5:
			animated_sprite.play("se-walk")
		if dir.x < -0.5 and dir.y > 0.5:
			animated_sprite.play("sw-walk")
		if dir.x < -0.5 and dir.y < -0.5:
			animated_sprite.play("nw-walk")

func player():
	pass

func collect(item):
	inv.insert(item)
	
