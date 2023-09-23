extends Area2D

signal sword

var player_in_area = false
var is_open = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("press_O") and not is_open:
		is_open = true
		emit_signal("sword")
		$RegularChest/AnimationPlayer.play("open")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Chest_body_entered(body):
	player_in_area = true


func _on_Chest_body_exited(body):
	player_in_area = false
