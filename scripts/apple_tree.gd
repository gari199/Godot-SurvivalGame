extends Node2D


var state = "no apples" #no apples or apples
var player_in_area = false

@onready var growth_timer: Timer = $growth_timer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var marker: Marker2D = $Marker2D


var apple = preload("res://scenes/apple_collectable.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if state == "no apples":
		growth_timer.start()

func _process(delta: float) -> void:
	if state == "no apples":
		animated_sprite.play("no_apples")
	else:
		animated_sprite.play("apples")
		if player_in_area:
			if Input.is_action_just_pressed("pick"):
				state = "no apples"
				drop_apple()

#Checks if the body entered the area has the methos "player". We have defined it in the player script
func _on_pickable_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true

func _on_pickable_area_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false

#Timeout signal to apple tree: When the time has passed since growth_timer.start() -->
func _on_growth_timer_timeout() -> void:
	state = "apples"

func drop_apple():
	var apple_instance = apple.instantiate()
	apple_instance.global_position = marker.global_position
	get_parent().add_child(apple_instance)
	
	await get_tree().create_timer(3.0).timeout
		
		
