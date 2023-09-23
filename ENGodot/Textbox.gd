extends CanvasLayer

const read_rate = 0.05

onready var tb_container = $TextBoxContainer
onready var label_text =$TextBoxContainer/Panel/MarginContainer/HBoxContainer/Label

enum State {
	ready 
	read
	finish
}

var current_state = State.ready
var queue = []

func _ready():
	hide_tb()
	text_queue("Welcome to the Ethereal Nexus!")
	text_queue("You are a treasure hunter named Vyn Wilkes.")
	text_queue("You just crash landed at the Forest...")
	text_queue("in search of the fabled Nexus Sphere!")
	text_queue("Time for you and Slinky to begin exploring!")
	pass # Replace with function body.

func _process(delta):
	match current_state:
		State.ready:
			if !queue.empty():
				show_text()
		State.read:
			if Input.is_action_just_pressed("ui_accept"):
				label_text.percent_visible = 1.0
				$Tween.remove_all()
				change_state(State.finish)
		State.finish:
			if Input.is_action_just_pressed("ui_accept"):
				change_state(State.ready)
				hide_tb()
		
func text_queue(new_text):
	queue.push_back(new_text)

func hide_tb():
	label_text.text = ""
	tb_container.hide()
	
func show_tb():
	tb_container.show()
	
func show_text():
	var camera_pos_x = get_parent().get_node("Player/Camera2D").position.x
	var camera_pos_y = get_parent().get_node("Player/Camera2D").position.y
	var tb_pos = Vector2(camera_pos_x + 115, camera_pos_y + 435)
	set_offset(tb_pos)
	var new_text = queue.pop_front()
	label_text.text = new_text
	label_text.percent_visible = 0.0
	change_state(State.read)
	show_tb()
	$Tween.interpolate_property(label_text, "percent_visible", 0.0, 1.0, len(new_text) * read_rate, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	
func change_state(new_state):
	current_state = new_state
	
func _on_Tween_tween_completed(object, key):
	change_state(State.finish)


func _on_Chest_sword():
	text_queue("You have unlocked an ancient sword!")
