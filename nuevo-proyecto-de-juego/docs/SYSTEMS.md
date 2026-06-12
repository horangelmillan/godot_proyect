# Documentación de Sistemas

Descripción detallada de cada sistema implementado en el motor.

---

## Sistema de Gestión de Estado (GameManager)

**Archivo:** `core/autoload/GameManager.gd`

**Versión:** 1.0 (Fase 0)

### Descripción
GameManager es el corazón centralizado del estado del juego. Mantiene:
- Estado de la historia actual (story flags)
- Datos del jugador (posición, stats)
- Estado del mundo (NPCs visitados, ubicaciones)
- Quests activas y completadas

### API Pública

#### Gestión de Historias
```gdscript
func load_story(story_id: String) -> void
# Carga una nueva historia y resetea el estado

func reset_story_state() -> void
# Limpia todos los flags, quests y estado del mundo
```

#### Gestión de Story Flags
```gdscript
func set_story_flag(flag_name: String, value: bool) -> void
# Establece un flag y emite señal

func get_story_flag(flag_name: String, default_value: bool = false) -> bool
# Obtiene valor de un flag (default: false)

func has_story_flag(flag_name: String) -> bool
# Retorna true si el flag existe y es true
```

#### Gestión de Quests
```gdscript
func accept_quest(quest_id: String) -> void
func complete_quest(quest_id: String) -> void
func is_quest_active(quest_id: String) -> bool
func is_quest_completed(quest_id: String) -> bool
```

#### Gestión de Mundo
```gdscript
func visit_npc(npc_id: String) -> void
func visit_location(location_id: String) -> void
```

#### Guardado y Cargado
```gdscript
func save_game(slot: int) -> void
# Guarda estado en user://saves/save_N.json

func load_game(slot: int) -> bool
# Carga estado desde archivo. Retorna true si éxito
```

### Propiedades Públicas

```gdscript
var current_story: String          # "violet_evergarden"
var story_flags: Dictionary        # {"met_elder": true, ...}
var player_data: Dictionary        # {"position": Vector3(...), ...}
var world_state: Dictionary        # {"npcs_visited": [...], ...}
var active_quests: Array[String]   # ["quest_1", "quest_2"]
var completed_quests: Array[String]
```

### Ejemplos de Uso

**Ejemplo 1: Marcar que encontraste a un personaje**
```gdscript
# En NPC.gd
func interact(player):
    face_player(player)
    GameManager.set_story_flag("met_elder", true)
    var ui = get_tree().get_first_node_in_group("ui")
    if ui:
        ui.start_dialogue(dialogue)
```

**Ejemplo 2: Verificar flag antes de diálogo**
```gdscript
# En NPC.gd
func get_dialogue_for_player():
    if GameManager.has_story_flag("completed_main_quest"):
        return dialogue_after_quest
    else:
        return dialogue_before_quest
```

**Ejemplo 3: Guardar partida**
```gdscript
# En UI o controlador de menú
func save_current_game():
    GameManager.save_game(1)  # Slot 1
```

---

## Sistema de Señales (GameEvents)

**Archivo:** `core/autoload/GameEvents.gd`

**Versión:** 1.0 (Fase 0)

### Descripción
GameEvents emite señales cuando el estado cambia. Permite que scripts reaccionen sin acoplamiento directo.

### Señales Disponibles

```gdscript
signal story_flag_changed(flag_name: String, value: bool)
# Emitida cuando GameManager.set_story_flag() es llamado

signal quest_accepted(quest_id: String)
# Emitida cuando un quest es aceptado

signal quest_completed(quest_id: String)
# Emitida cuando un quest es completado

signal dialogue_started(dialogue_id: String)
# Emitida cuando inicia un diálogo

signal dialogue_ended()
# Emitida cuando termina un diálogo

signal npc_visited(npc_id: String)
# Emitida cuando el jugador interactúa con un NPC

signal location_visited(location_id: String)
# Emitida cuando el jugador visita una ubicación

signal game_saved()
# Emitida después de guardar

signal game_loaded()
# Emitida después de cargar

signal player_moved(position: Vector3)
# Emitida cada frame cuando el jugador se mueve
```

### Patrón de Conexión

```gdscript
# En _ready()
GameEvents.story_flag_changed.connect(_on_story_flag_changed)
GameEvents.quest_accepted.connect(_on_quest_accepted)

# Manejo de señal
func _on_story_flag_changed(flag_name: String, value: bool) -> void:
    print("Flag %s cambió a %s" % [flag_name, value])
    if flag_name == "completed_main_quest":
        show_credits()
```

### Desconexión (Cleanup)

```gdscript
# En _exit_tree() para evitar memory leaks
GameEvents.story_flag_changed.disconnect(_on_story_flag_changed)
```

---

## Sistema de Diálogos

**Archivos:** 
- `core/systems/dialogue/npc.gd` - Componente NPC
- `core/systems/ui/dialogue_ui.gd` - Interfaz de diálogos
- `core/systems/camera/camera_controller.gd` - Cámara (integrada)

**Versión:** 1.0 (Fase 0) - Diálogos hardcoded. Fase 1: DialogueResource

### Descripción
Sistema de interacción NPC → Diálogos con máquina de escribir.

### Flujo de Diálogo

```
1. Jugador presiona E cerca de NPC
2. Player.handle_interaction() detecta NPC
3. NPC.interact(player) es llamado
4. NPC emite señal y llama UI.start_dialogue()
5. UI.start_dialogue() inicia efecto de máquina de escribir
6. Cámara se acerca (camera.enter_dialogue())
7. Jugador no puede moverse
8. Presionar E muestra siguiente línea
9. Al terminar, se cierra diálogo y se restaura cámara
```

### API: NPC

```gdscript
# En NPC.gd
var npc_id: String = "npc_default"      # ID único
var npc_name: String = "NPC"            # Nombre mostrado
var dialogue: Array[String] = [...]     # Líneas a mostrar

func interact(player) -> void           # Llamado al interactuar
func face_player(player) -> void        # Gira hacia el jugador
```

### API: UI Diálogos

```gdscript
# En dialogue_ui.gd
func start_dialogue(lines: Array) -> void    # Inicia diálogo
func next_dialogue() -> void                 # Siguiente línea
func hide_dialogue() -> void                 # Cierra diálogo
func is_dialogue_open() -> bool              # ¿Abierto?
```

### Cómo Usar en tu Historia

**Fase 0 (Actual - Hardcoded):**
```gdscript
# En core/systems/dialogue/npc.gd
var dialogue = [
    "Hola aventurero",
    "¿Cómo estás?",
    "Cuéntame tu historia"
]
```

**Fase 1 (Próximo - DialogueResource):**
```gdscript
# En stories/mi_historia/scenes/main_plaza.tscn
# NPC tendrá referencia a: res://stories/mi_historia/data/dialogues/npc_intro.tres
# DialogueResource contendrá las líneas
```

---

## Sistema de Movimiento del Jugador

**Archivo:** `core/systems/player/player_controller.gd`

**Versión:** 1.0 (Fase 0)

### Descripción
Controla al jugador: movimiento, saltos, interacción con NPCs.

### Controles

| Tecla | Acción |
|-------|--------|
| WASD  | Movimiento |
| Espacio | Salto |
| E | Interactuar / Siguiente diálogo |

### Parámetros Configurables

```gdscript
const SPEED = 5.0              # Velocidad de movimiento
const JUMP_VELOCITY = 2        # Altura del salto
var interaction_distance = 1.5 # Radio de interacción
```

### Física

- Movimiento: CharacterBody3D con `move_and_slide()`
- Gravedad: Aplicada automáticamente por Godot
- Colisiones: CapsuleShape3D

### Bloqueo Durante Diálogos

```gdscript
# En _physics_process
var ui = get_tree().get_first_node_in_group("ui")
if ui and ui.is_dialogue_open():
    velocity.x = 0
    velocity.z = 0
    move_and_slide()
    return  # No procesar más input
```

---

## Sistema de Cámara

**Archivo:** `core/systems/camera/camera_controller.gd`

**Versión:** 1.0 (Fase 0)

### Descripción
Cámara 3D que sigue al jugador con transiciones suaves.

### Parámetros

```gdscript
var exploration_offset = Vector3(0, 5, 5)   # Posición en exploración
var dialogue_offset = Vector3(0, 3, 3)      # Posición en diálogo
var follow_speed = 5.0                       # Velocidad de transición
```

### Métodos

```gdscript
func enter_dialogue() -> void
# Cambia a dialogue_offset (zoom in)

func exit_dialogue() -> void
# Vuelve a exploration_offset (zoom out)
```

### Fórmula de Posición

```gdscript
target_position = player.global_position + current_offset
camera.global_position = lerp(camera.global_position, target_position, delta * follow_speed)
```

---

## Sistema de UI (Diálogos)

**Archivo:** `core/systems/ui/dialogue_ui.gd`

**Versión:** 1.0 (Fase 0)

### Descripción
Panel con texto que simula máquina de escribir.

### Estructura en Main.tscn

```
UI (CanvasLayer)
└── RootUI (Control)
    └── DialogueBox (Panel)
        ├── Content (MarginContainer)
        │   └── DialogueText (RichTextLabel)
        └── Footer (MarginContainer)
            └── ContinueIndicator (Label) "▼"
```

### Parámetros de Máquina de Escribir

```gdscript
await get_tree().create_timer(0.03).timeout  # 30ms entre letras
```

Cambiar este valor para ajustar velocidad.

---

## Próximos Sistemas (Roadmap)

### Fase 1: DialogueResource y CharacterResource
**Propósito:** Desacoplar datos de diálogos del código.  
**Estado:** PENDING

### Fase 2: StoryFlagSystem Mejorado
**Propósito:** Condiciones complejas en diálogos.  
**Estado:** PENDING

### Fase 3: QuestSystem
**Propósito:** Gestión de misiones con estados.  
**Estado:** PENDING

### Fase 4: SaveSystem Mejorado
**Propósito:** Múltiples slots, metadata de guardos.  
**Estado:** PENDING

---

## Performance Consideraciones

| Sistema | Overhead | Notas |
|---------|----------|-------|
| GameManager | Muy bajo | Single dictionary access |
| GameEvents | Bajo | Solo se emite en cambios de estado |
| Diálogos | Bajo | La máquina de escribir es asincrónica (no bloquea) |
| Cámara | Muy bajo | Interpolación simple con lerp |
| Player | Bajo | Physics engine nativo de Godot |

---

## Debugging

### Ver state actual
```gdscript
# En consola de Godot
print(GameManager.story_flags)
print(GameManager.active_quests)
```

### Resetear estado (desarrollo)
```gdscript
# En _ready de una escena de prueba
GameManager.reset_story_state()
```

### Escuchar cambios de flags
```gdscript
func _ready():
    GameEvents.story_flag_changed.connect(
        func(flag, value): print("%s = %s" % [flag, value])
    )
```

---

## Referencias

- [ARCHITECTURE.md](./ARCHITECTURE.md) - Visión general
- [STORY_TEMPLATE.md](./STORY_TEMPLATE.md) - Crear nueva historia
