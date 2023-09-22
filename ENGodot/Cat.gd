extends KinematicBody2D
export var speed = 150
var motion
var player_pos
var target_pos
signal is_moving
onready var player = get_parent().get_node("Player")

# Declare member variables here. Examples: 
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.position.x = 33
	$Sprite.position.y = 20
	pass # Replace with function body.

func _physics_process(delta):
	player_pos = player.position
	target_pos = (player_pos - position).normalized()
	if position.distance_to(player_pos) > 3:
		move_and_slide(target_pos * speed)
	if !player.move.is_equal_approx(Vector2(0,0)):
		if Input.is_action_pressed("ui_left"):
			$Sprite.flip_h = true
		if Input.is_action_pressed("ui_right"):
			$Sprite.flip_h = false
		$Sprite/AnimationPlayer.play("walk")
	else:
		$Sprite/AnimationPlayer.play("idle")
			
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
