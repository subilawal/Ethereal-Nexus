extends KinematicBody2D
var speed = 150
var velocity = Vector2()
var moving
var looking = "down"
export var move = 0
signal is_moving
signal open_chest


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		$Sprite/AnimationPlayer.play("walk_right")
		$CatSprite/AnimationPlayer.play("walk")
		$CatSprite.flip_h = false
		$CatSprite.position.x = 63
		$CatSprite.position.y = 33
		velocity.x += 1
		looking = "right"
		moving = true
	elif Input.is_action_pressed("ui_left"):
		$Sprite/AnimationPlayer.play("walk_left")
		$CatSprite/AnimationPlayer.play("walk")
		$CatSprite.flip_h = true
		$CatSprite.position.x = 96
		$CatSprite.position.y = 33
		velocity.x -= 1
		looking = "left"
		moving = true
	elif Input.is_action_pressed("ui_up"):
		$Sprite/AnimationPlayer.play("walk_up")
		$CatSprite/AnimationPlayer.play("walk")
		velocity.y -= 1
		looking = "up"
		moving = true
		$CatSprite.position.x = 80
		$CatSprite.position.y = 50
	elif Input.is_action_pressed("ui_down"):
		$Sprite/AnimationPlayer.play("walk_down")
		$CatSprite/AnimationPlayer.play("idle")
		$CatSprite.position.x = 80
		$CatSprite.position.y = 10
		velocity.y += 1
		looking = "down"
		moving = true
	else:
		if looking == "up":
			$Sprite/AnimationPlayer.play("idle_backwards")
		elif looking == "left":
			$Sprite/AnimationPlayer.play("idle_left")
		elif looking == "right":
			$Sprite/AnimationPlayer.play("idle_right")
		elif looking == "down":
			$Sprite/AnimationPlayer.play("idle")
		$CatSprite/AnimationPlayer.play("idle")
		moving = false
	move = velocity * speed
	move_and_slide(move)
	
	
func _is_moving():
	if moving == true:
		return true
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_is_moving():
	if moving == true:
		return true
	pass # Replace with function body.


func _on_Timer_timeout():
	$Timer.wait_time = rand_range(10, 30)
	$CatSprite/AnimationPlayer.play("lick")
	$CatSprite/AnimationPlayer.play("lick")
	pass # Replace with function body.


func _on_Chest_area_entered(area):
	emit_signal("open_chest")
	pass # Replace with function body.
