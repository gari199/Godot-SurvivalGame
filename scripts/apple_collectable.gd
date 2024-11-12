extends StaticBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	fallfromtree()

func fallfromtree():
	animation_player.play("fallingfromtree")
	await get_tree().create_timer(1.5).timeout
	animation_player.play("fade")
	print("+1 apples")
	await get_tree().create_timer(0.3).timeout
	queue_free()
