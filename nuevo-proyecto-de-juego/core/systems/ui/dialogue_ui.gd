extends CanvasLayer

@onready var dialogue_box = $RootUI/DialogueBox
@onready var dialogue_text = $RootUI/DialogueBox/Content/DialogueText
@onready var continue_indicator = $RootUI/DialogueBox/Footer/ContinueIndicator

var indicator_animator: AnimationPlayer
var dialogue_open = false
var dialogue_lines = []
var current_line = 0
var is_typing = false
var full_text = ""

# Parámetros de animación de la flecha (dinámicos)
@export var arrow_bob_speed: float = 1.5
@export var arrow_bob_height: float = 8.0

func _ready() -> void:
	indicator_animator = continue_indicator.get_node("AnimationPlayer")
	print("AnimationPlayer encontrado: ", indicator_animator)
	setup_arrow_animation()
	continue_indicator.visible = false
	print("Flecha inicialmente oculta")

func setup_arrow_animation() -> void:
	if not indicator_animator.has_animation("bob"):
		var anim = Animation.new()
		anim.length = arrow_bob_speed * 2

		var track_idx = anim.add_track(Animation.TYPE_VALUE)
		anim.track_set_path(track_idx, "Label:offset:y")

		anim.track_insert_key(track_idx, 0, -10)
		anim.track_insert_key(track_idx, arrow_bob_speed, -10 - arrow_bob_height)
		anim.track_insert_key(track_idx, arrow_bob_speed * 2, -10)

		anim.set_loop_mode(Animation.LOOP_LINEAR)
		indicator_animator.add_animation("bob", anim)

func show_arrow() -> void:
	print("Show arrow llamado")
	continue_indicator.visible = true
	print("Reproduciendo animación...")
	indicator_animator.play("bob")
	print("Animación iniciada")

func hide_arrow() -> void:
	print("Hide arrow llamado")
	continue_indicator.visible = false
	indicator_animator.stop()

func start_typing():
	is_typing = true
	hide_arrow()

	for letter in full_text:
		dialogue_text.text += letter
		await get_tree().create_timer(0.03).timeout

	is_typing = false
	show_arrow()

func show_dialogue(text: String):
	full_text = text
	dialogue_text.text = ""

	start_typing()
	dialogue_box.visible = true
	dialogue_open = true
	var camera = get_tree().get_first_node_in_group("main_camera")

	if camera:
		camera.enter_dialogue()

	GameEvents.dialogue_started.emit("")

func hide_dialogue():
	dialogue_box.visible = false
	dialogue_open = false
	hide_arrow()
	var camera = get_tree().get_first_node_in_group("main_camera")

	if camera:
		camera.exit_dialogue()

	GameEvents.dialogue_ended.emit()

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
