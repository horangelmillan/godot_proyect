extends CanvasLayer

@onready var dialogue_box = $DialogueBox
@onready var dialogue_text = $DialogueBox/DialogueText

func show_dialogue(text):

	dialogue_text.text = text
	dialogue_box.visible = true

func hide_dialogue():

	dialogue_box.visible = false
