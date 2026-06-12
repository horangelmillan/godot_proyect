# Plantilla para Crear una Nueva Historia

Esta plantilla guía el proceso de crear una nueva historia reutilizable en el motor.

## Paso 1: Crear la Estructura de Carpetas

```bash
res://stories/nombre_historia/
├── data/
│   ├── characters/
│   ├── dialogues/
│   ├── quests/
│   └── world_config.gd
├── scenes/
├── STORY_STATE.md
└── README.md
```

**Comandos:**
```bash
mkdir -p stories/nombre_historia/{data/{characters,dialogues,quests},scenes}
```

---

## Paso 2: Crear `STORY_STATE.md`

**Ubicación:** `stories/nombre_historia/STORY_STATE.md`

**Propósito:** Documentar TODOS los story flags, variables y estado de la historia.

**Plantilla:**

```markdown
# Estado de Historia - Nombre de Historia

Última actualización: 2026-06-12

## Propósito
Breve descripción de la historia (1-2 párrafos).

## Acto I
[Describir acto, personajes, conflicto]

## Variables Narrativas (Story Flags)

### Conocimiento de Personajes
- `met_protagonist` (bool) - ¿Conoce al protagonista?
- `protagonist_likes_player` (int) - Nivel de afecto (0-100)

### Progreso de Misiones
- `main_quest_active` (bool)
- `main_quest_completed` (bool)
- `side_quests_completed` (Array[String])

### Estado del Mundo
- `visited_locations` (Array[String])
- `npcs_defeated` (Array[String])
- `time_of_day` (String) - "morning", "afternoon", "night"

## Personajes Principales
- **Nombre:** Rol, descripción breve

## Escenas
- `scenes/main_plaza.tscn` - Primera escena
- `scenes/protagonist_home.tscn` - Hogar del protagonista

## Notas para Desarrollador
- Punto de entrada: main_plaza
- Duración esperada: X horas
- Restricciones técnicas: Ninguna
```

---

## Paso 3: Crear `world_config.gd`

**Ubicación:** `stories/nombre_historia/data/world_config.gd`

**Propósito:** Inicializar la historia, cargar personajes, escenas, condiciones iniciales.

**Plantilla:**

```gdscript
# stories/nombre_historia/data/world_config.gd
extends "res://core/story/StoryBase.gd"

func _ready() -> void:
    story_id = "nombre_historia"
    story_type = "circular_world"  # o "dungeon", "city", etc.
    
    load_initial_state()
    load_characters()
    load_scenes()

func load_initial_state() -> void:
    # Inicializar story flags
    GameManager.set_story_flag("met_protagonist", false)
    GameManager.set_story_flag("main_quest_active", false)

func load_characters() -> void:
    # Cargar NPCs desde resources (Fase 1)
    # Ej: var protagonist = load("res://stories/nombre_historia/data/characters/protagonist.tres")
    pass

func load_scenes() -> void:
    # Cargar escenas iniciales
    pass
```

---

## Paso 4: Crear NPCs (CharacterResource)

**Ubicación:** `stories/nombre_historia/data/characters/npc_name.tres`

**Propósito:** Definir datos de NPCs de forma reutilizable.

**En Godot UI (crear manualmente):**
1. Right-click en `stories/nombre_historia/data/characters/`
2. New Resource → CharacterResource (Fase 1)
3. Configurar:
   - `id: "npc_name"`
   - `name: "NPC Name"`
   - `position: Vector3(5, 0, 0)`
   - `dialogue_id: "npc_name_intro"`

---

## Paso 5: Crear Diálogos (DialogueResource)

**Ubicación:** `stories/nombre_historia/data/dialogues/dialogue_name.tres`

**Propósito:** Almacenar líneas de diálogo con condiciones.

**En Godot UI (crear manualmente):**
1. Right-click en `stories/nombre_historia/data/dialogues/`
2. New Resource → DialogueResource (Fase 1)
3. Configurar líneas:
   ```
   Line 0:
   - text: "¡Hola! ¿Quién eres?"
   - conditions: {} (sin condiciones)
   - next_dialogue: "dialogue_name" (siguiente ID)
   
   Line 1:
   - text: "Soy [Player Name]. Encantado."
   - conditions: {"has_flag": "met_protagonist"} (solo si cumple
   - next_dialogue: "dialogue_name_continue"
   ```

---

## Paso 6: Crear Quests (QuestResource) - Fase 3

**Ubicación:** `stories/nombre_historia/data/quests/quest_name.tres`

**En Godot UI (crear manualmente):**
1. Right-click en `stories/nombre_historia/data/quests/`
2. New Resource → QuestResource (Fase 3)
3. Configurar:
   - `id: "quest_deliver_letter"`
   - `title: "Entregar Carta"`
   - `description: "El protagonista te pide entregar una carta"`
   - `giver_npc_id: "protagonist"`
   - `objective: "Encuentra al destinatario en el pueblo"`
   - `reward: {"gold": 100}`
   - `completion_flag: "quest_deliver_letter_completed"`

---

## Paso 7: Crear Escenas

**Ubicación:** `stories/nombre_historia/scenes/main_plaza.tscn`

**Pasos:**
1. Crear nueva escena 3D
2. Agregar nodos:
   - Floor (StaticBody3D + CollisionShape3D + MeshInstance3D)
   - NPCs (instancias de NPC.tscn con posiciones)
   - Puntos de interés (Area3D para triggers)
3. Guardar en `stories/nombre_historia/scenes/`

---

## Checklist de Implementación

### Especificación
- [ ] `STORY_STATE.md` escrito con todos los story flags
- [ ] `README.md` con descripción de la historia
- [ ] Personajes principales documentados
- [ ] Flujo narrativo claro

### Implementación
- [ ] `world_config.gd` creado
- [ ] CharacterResources creados para NPCs
- [ ] DialogueResources creados para diálogos
- [ ] Escenas (.tscn) creadas
- [ ] NPCs posicionados en escenas

### Testing
- [ ] Historia carga sin errores
- [ ] Jugador puede moverse
- [ ] Puede hablar con NPCs
- [ ] Diálogos muestran correctamente
- [ ] Story flags se actualizan (en Fase 2)
- [ ] Guardado/cargado funciona (en Fase 4)

### Documentación
- [ ] README.md completado
- [ ] Instrucciones para jugar
- [ ] Notas técnicas para el siguiente desarrollador

---

## Ejemplo Mínimo Funcional (MVP)

```
stories/primer_intento/
├── data/
│   ├── characters/
│   │   └── anciano.tres
│   ├── dialogues/
│   │   └── anciano_intro.tres
│   ├── quests/
│   └── world_config.gd
├── scenes/
│   └── plaza.tscn
├── STORY_STATE.md
└── README.md
```

**Requisitos mínimos:**
1. 1 escena con piso y NPC
2. 1 NPC con 3 líneas de diálogo
3. Jugador puede caminar y hablar
4. Story flag se activa al hablar

---

## Pasos Siguientes (Post-MVP)

1. Agregar quests (Fase 3)
2. Agregar más escenas y cambio de mapas (Fase 7)
3. Agregar inventario (Fase 6)
4. Agregar animaciones (Fase 8)
5. Pulir narrativa y jugabilidad

---

## Troubleshooting

**Pregunta:** ¿Cómo cargó recursos desde `stories/`?  
**Respuesta:** Usa `ResourceLoader.gd` (Fase 1):
```gdscript
var character = GameManager.resource_loader.load_story_resource(
    "nombre_historia", "characters", "npc_name"
)
```

**Pregunta:** ¿Cómo accedo a story flags?  
**Respuesta:** Usa `GameManager`:
```gdscript
if GameManager.has_story_flag("met_protagonist"):
    # Mostrar diálogo diferente
    pass
```

**Pregunta:** ¿Las historias pueden compartir NPCs?  
**Respuesta:** Sí. Puedes crear NPCs compartidos en `assets/characters/` y referenciarlos desde múltiples historias.

---

## Referencias

- [ARCHITECTURE.md](./ARCHITECTURE.md) - Arquitectura del motor
- [SYSTEMS.md](./SYSTEMS.md) - Documentación de sistemas individuales
- Ejemplo: `stories/violet_evergarden/` - Implementación de referencia
