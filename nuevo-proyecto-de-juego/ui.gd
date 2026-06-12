extends CanvasLayer

@onready var dialogue_box = $DialogueBox
@onready var dialogue_text = $DialogueBox/DialogueText
var dialogue_open = false

func show_dialogue(text):

	dialogue_text.text = text
	dialogue_box.visible = true
	dialogue_open = true

func hide_dialogue():

	dialogue_box.visible = false
	dialogue_open = false

func is_dialogue_open():
	return dialogue_open
	
func consume_interact():
	return dialogue_open
	
func toggle_dialogue():

	if dialogue_open:
		hide_dialogue()
