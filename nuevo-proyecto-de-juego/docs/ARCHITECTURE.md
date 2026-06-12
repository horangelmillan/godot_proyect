# Arquitectura del Motor RPG Narrativo

## Visión General

Este proyecto implementa un motor de juego RPG reutilizable basado en **Specification-Driven Development** (SDD) que permite crear múltiples historias narrativas (como Violet Evergarden) sin modificar el código core.

### Principios Arquitectónicos

1. **Separación: Contenido ≠ Código** - Los datos (diálogos, NPCs, quests) viven en `/stories/` completamente independientes del motor.
2. **Flexibilidad por Historia** - Cada historia puede tener su propia estructura siempre que respete la interfaz core.
3. **Arquitectura Centralizada** - GameManager controla el estado global sin contaminar el árbol de nodos.
4. **Escalabilidad** - Diseñado para agregar nuevas historias, sistemas y características sin refactorizar el core.

---

## Estructura de Carpetas

```
res://
├── core/                      # Motor reutilizable (NO MODIFICAR POR HISTORIAS)
│   ├── autoload/
│   │   ├── GameManager.gd    # Estado global centralizado
│   │   └── GameEvents.gd     # Sistema de señales
│   ├── systems/
│   │   ├── dialogue/         # Sistema de diálogos
│   │   ├── player/           # Controlador del jugador
│   │   ├── camera/           # Controlador de cámara
│   │   ├── ui/               # UI compartida
│   │   ├── quest/            # Sistema de quests (Fase 3)
│   │   └── save/             # Sistema de guardado (Fase 4)
│   ├── utils/                # Utilidades compartidas
│   └── story/                # Clase base para historias
│
├── stories/                   # Contenido específico por historia
│   ├── violet_evergarden/    # Historia: Violet Evergarden
│   │   ├── scenes/           # Escenas de esta historia
│   │   ├── data/
│   │   │   ├── characters/   # NPCs (CharacterResource)
│   │   │   ├── dialogues/    # Diálogos (DialogueResource)
│   │   │   ├── quests/       # Misiones (QuestResource)
│   │   │   └── world_config.gd  # Configuración del mundo
│   │   ├── STORY_STATE.md    # Variables narrativas documentadas
│   │   └── README.md         # Documentación de la historia
│   └── [future_story]/       # Otras historias (futuro)
│
├── assets/                    # Recursos compartidos
│   ├── models/
│   ├── textures/
│   ├── characters/
│   └── audio/
│
├── docs/                      # Documentación
│   ├── ARCHITECTURE.md       # Este archivo
│   ├── STORY_TEMPLATE.md     # Plantilla para nuevas historias
│   └── SYSTEMS.md            # Documentación de sistemas
│
├── saves/                     # Archivos de guardado
├── Main.tscn                  # Escena principal
└── project.godot
```

---

## Componentes Clave

### 1. GameManager (Autoload)

**Ubicación:** `core/autoload/GameManager.gd`

**Responsabilidad:** Centralizar TODO el estado global del juego.

**Estado Gestionado:**
- `current_story: String` - Historia activa
- `story_flags: Dictionary` - Variables narrativas (met_elder, completed_quest, etc.)
- `player_data: Dictionary` - Datos del jugador (posición, stats)
- `world_state: Dictionary` - Estado del mundo (NPCs visitados, ubicaciones)
- `active_quests: Array` - Quests en progreso
- `completed_quests: Array` - Quests completadas

**Métodos Críticos:**
```gdscript
GameManager.set_story_flag("met_elder", true)
GameManager.accept_quest("deliver_letter")
GameManager.save_game(1)
GameManager.load_game(1)
```

**Ventajas:**
- ✅ Reemplaza `get_tree().get_first_node_in_group()` (menos acoplamiento)
- ✅ Persiste automáticamente entre escenas
- ✅ Facilita debugging y pruebas
- ✅ Histórico completo en una ubicación

---

### 2. GameEvents (Autoload)

**Ubicación:** `core/autoload/GameEvents.gd`

**Responsabilidad:** Emitir señales cuando el estado cambia.

**Señales Principales:**
```gdscript
story_flag_changed(flag_name, value)
quest_accepted(quest_id)
quest_completed(quest_id)
dialogue_started(dialogue_id)
dialogue_ended()
npc_visited(npc_id)
game_saved()
game_loaded()
```

**Patrón de Uso:**
```gdscript
# Escuchar cambios
GameEvents.story_flag_changed.connect(on_flag_changed)

# Emitir cambios
GameEvents.story_flag_changed.emit("met_elder", true)
```

---

### 3. Sistemas Modulares

#### 3.1 Sistema de Diálogos (`core/systems/dialogue/`)

**Archivos:**
- `npc.gd` - Componente de NPC
- `DialogueResource.gd` - Recurso con líneas de diálogo (Fase 1)
- `DialogueUI.gd` - Interfaz de diálogos (refactorizado)

**Flujo:**
```
Jugador interactúa
→ NPC.interact(player)
→ UI.start_dialogue(lines)
→ Mostrar líneas con efecto de máquina de escribir
→ Presionar E para siguiente línea
```

#### 3.2 Controlador del Jugador (`core/systems/player/`)

**Archivo:** `player_controller.gd`

**Funcionalidades:**
- Movimiento WASD con física 3D
- Gravedad y saltos
- Interacción con NPCs
- Bloqueo de movimiento durante diálogos

#### 3.3 Cámara (`core/systems/camera/`)

**Archivo:** `camera_controller.gd`

**Funcionalidades:**
- Seguimiento suave del jugador (exploración)
- Zoom al diálogo
- Rotación automática hacia el jugador

#### 3.4 UI (`core/systems/ui/`)

**Archivo:** `dialogue_ui.gd`

**Componentes:**
- DialogueBox (Panel)
- DialogueText (RichTextLabel)
- ContinueIndicator (▼)

---

## Flujo de una Historia (Spec-Driven)

### Fase de Especificación
1. Crear carpeta en `stories/nueva_historia/`
2. Documentar variables en `STORY_STATE.md`
3. Definir NPCs, diálogos, quests en `data/`

### Fase de Implementación
1. Crear `world_config.gd` que extiende `StoryBase`
2. Cargar datos desde resources
3. Conectar NPCs y diálogos
4. Integrar con GameManager

### Fase de Testing
1. Ejecutar historia sin modificar core
2. Verificar que story flags funcionan
3. Probar guardado/cargado

---

## Decisiones Arquitectónicas (ADR)

### ADR-001: Centralizar Estado en GameManager
**Problema:** Los scripts estaban usando `get_tree().get_first_node_in_group()` para acceder a referencias globales.  
**Solución:** Crear GameManager como autoload que mantiene TODO el estado.  
**Beneficios:** Menos acoplamiento, debugging más fácil, persistencia centralizada.  
**Trade-off:** Requiere actualizar todos los accesos a estado global.

### ADR-002: Separar `core/` y `stories/`
**Problema:** Código específico de historias estaba mezclado con motor reutilizable.  
**Solución:** Separar completamente en directorios.  
**Beneficios:** Claridad, reutilización, fácil agregar nuevas historias.  
**Trade-off:** Más carpetas, requiere disciplina en organización.

### ADR-003: GameEvents para Comunicación
**Problema:** Scripts modificaban estado sin que otros supieran los cambios.  
**Solución:** Emitir señales cuando GameManager cambia.  
**Beneficios:** Desacoplamiento, reactividad, debugging.  
**Trade-off:** Pequeño overhead de rendimiento (negligible).

---

## Patrones de Uso Comunes

### Patrón 1: Ejecutar Diálogo Condicional
```gdscript
# En NPC
if GameManager.has_story_flag("met_elder"):
    ui.start_dialogue(dialogue_after_meeting)
else:
    ui.start_dialogue(dialogue_first_meeting)
    GameManager.set_story_flag("met_elder", true)
```

### Patrón 2: Aceptar Quest desde Diálogo
```gdscript
# En NPC
GameManager.accept_quest("deliver_letter")
GameEvents.quest_accepted.emit("deliver_letter")
```

### Patrón 3: Escuchar Cambios
```gdscript
# En Script que necesita reaccionar
func _ready():
    GameEvents.story_flag_changed.connect(on_flag_changed)

func on_flag_changed(flag_name: String, value: bool):
    if flag_name == "completed_main_quest":
        show_celebration()
```

### Patrón 4: Guardar y Cargar
```gdscript
# Guardar
GameManager.save_game(1)

# Cargar
if GameManager.load_game(1):
    print("Partida cargada")
```

---

## Fases de Desarrollo

| Fase | Objetivo | Estado |
|------|----------|--------|
| 0 | Arquitectura Base | ✅ IN PROGRESS |
| 1 | Datos Desacoplados | ⏳ PENDING |
| 2 | Variables Narrativas | ⏳ PENDING |
| 3 | Sistema de Quests | ⏳ PENDING |
| 4 | Guardado y Persistencia | ⏳ PENDING |
| 5 | Multi-Historia | ⏳ PENDING |
| 6 | Inventario | ⏳ PENDING |
| 7 | Cambio de Mapas | ⏳ PENDING |
| 8 | Animaciones y Mundo Vivo | ⏳ PENDING |
| 9 | Vertical Slice Completo | ⏳ PENDING |
| 10 | Sistema de Combate | ⏳ FUTURE |

---

## Próximas Acciones

1. **Completar Fase 0:**
   - [ ] Verificar que Main.tscn carga sin errores
   - [ ] Crear STORY_TEMPLATE.md
   - [ ] Documentar decisiones finales

2. **Iniciar Fase 1:**
   - [ ] Crear DialogueResource.gd
   - [ ] Crear CharacterResource.gd
   - [ ] Crear ResourceLoader.gd

---

## Referencias

- Inspiración: Pokémon SoulSilver, Zelda Spirit Tracks, Final Fantasy DS
- Motor: Godot 4.6.3
- Metodología: Specification-Driven Development (SDD)
