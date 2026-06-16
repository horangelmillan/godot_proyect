extends CanvasLayer

@onready var dialogue_box = $RootUI/DialogueBox
@onready var dialogue_text = $RootUI/DialogueBox/Content/DialogueText
@onready var continue_indicator = $RootUI/DialogueBox/Footer/ContinueIndicator
@onready var arrow_label = continue_indicator.get_node("Label")

var dialogue_open = false
var dialogue_lines = []
var current_line = 0
var is_typing = false
var full_text = ""
var arrow_tween: Tween
var typing_tween: Tween
var skip_typing = false
var current_typing_id = 0

# Parámetros de animación de la flecha (dinámicos)
@export var arrow_bob_speed: float = 0.6
@export var arrow_bob_height: float = 15.0

func _ready() -> void:
	continue_indicator.visible = false
	print("Flecha inicialmente oculta")

func start_arrow_animation() -> void:
	if arrow_tween:
		arrow_tween.kill()

	arrow_tween = create_tween()
	arrow_tween.set_loops()
	arrow_tween.set_trans(Tween.TRANS_SINE)
	arrow_tween.set_ease(Tween.EASE_IN_OUT)

	print("Animando position:y del Label")
	# Anima la posición Y del label
	arrow_tween.tween_property(arrow_label, "position:y", -25, arrow_bob_speed)
	arrow_tween.tween_property(arrow_label, "position:y", 5, arrow_bob_speed)

func show_arrow() -> void:
	print("Show arrow llamado")
	continue_indicator.visible = true
	print("Iniciando animación de bobbing...")
	start_arrow_animation()
	print("Animación iniciada")

func hide_arrow() -> void:
	print("Hide arrow llamado")
	continue_indicator.visible = false
	if arrow_tween:
		arrow_tween.kill()
		arrow_tween = null

func start_typing():
	if typing_tween:
		typing_tween.kill()

	# Generar ID único para este typewriter
	current_typing_id += 1
	var typing_id = current_typing_id

	is_typing = true
	hide_arrow()

	for letter in full_text:
		
		if skip_typing:
			dialogue_text.text = full_text
			break
			
			# Cancelar si hay un typewriter más reciente
		if typing_id != current_typing_id:
			return

		dialogue_text.text += letter
		await get_tree().create_timer(0.03).timeout

	is_typing = false
	show_arrow()

	# Si se completó por skip, automáticamente avanzar al siguiente
	if skip_typing:
		await get_tree().create_timer(0.1).timeout

func show_dialogue(text: String):
	# Resetear estado de escritura anterior
	skip_typing = false
	is_typing = false
	dialogue_text.text = ""
	full_text = text

	dialogue_box.visible = true
	dialogue_open = true
	var camera = get_tree().get_first_node_in_group("main_camera")

	if camera:
		camera.enter_dialogue()

	GameEvents.dialogue_started.emit("")

	# Pequeño delay para que la cámara termine su transición
	await get_tree().create_timer(0.2).timeout
	start_typing()

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
	# Prevenir múltiples diálogos simultáneos
	if dialogue_open:
		return

	dialogue_lines = lines
	current_line = 0
	show_dialogue(dialogue_lines[current_line])

func next_dialogue():
	# Si está escribiendo, no hacer nada (esperar a que se complete)
	if is_typing:
		skip_typing = true
		return

	current_line += 1

	if current_line >= dialogue_lines.size():
		hide_dialogue()
		return

	show_dialogue(dialogue_lines[current_line])
