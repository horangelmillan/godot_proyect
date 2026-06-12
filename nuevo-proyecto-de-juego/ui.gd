extends CanvasLayer

@onready var dialogue_box = $RootUI/DialogueBox
@onready var dialogue_text = $RootUI/DialogueBox/Content/DialogueText
var dialogue_open = false
var dialogue_lines = []
var current_line = 0
var is_typing = false
var full_text = ""

func start_typing():

	is_typing = true

	for letter in full_text:

		dialogue_text.text += letter

		await get_tree().create_timer(0.03).timeout

	is_typing = false

func show_dialogue(text):

	full_text = text
	dialogue_text.text = ""

	start_typing()
	dialogue_box.visible = true
	dialogue_open = true
	var camera = get_tree().get_first_node_in_group("main_camera")

	if camera:
		camera.enter_dialogue()

func hide_dialogue():

	dialogue_box.visible = false
	dialogue_open = false
	var camera = get_tree().get_first_node_in_group("main_camera")

	if camera:
		camera.exit_dialogue()

func is_dialogue_open():
	return dialogue_open
	
func consume_interact():
	return dialogue_open
	
func toggle_dialogue():

	if dialogue_open:
		hide_dialogue()
		
func start_dialogue(lines):

	dialogue_lines = lines
	current_line = 0

	show_dialogue(dialogue_lines[current_line])

func next_dialogue():

	current_line += 1

	if current_line >= dialogue_lines.size():
		hide_dialogue()
		return

	show_dialogue(dialogue_lines[current_line])
