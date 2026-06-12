# Roadmap Oficial - Specification-Driven Development

**Última actualización:** 2026-06-12  
**Metodología:** Spec-Driven Development (SDD)  
**Motor:** Godot 4.6.3

---

# Fase 0: ✅ COMPLETADA - Arquitectura Base

## Estado: DONE

### Implementado
- ✅ GameManager (autoload) - Estado centralizado
- ✅ GameEvents (autoload) - Sistema de señales
- ✅ Estructura de carpetas (`/core`, `/stories/`, `/docs/`)
- ✅ Scripts refactorizados a nueva estructura
- ✅ Main.tscn actualizado
- ✅ ARCHITECTURE.md - Decisiones arquitectónicas
- ✅ STORY_TEMPLATE.md - Plantilla para nuevas historias
- ✅ SYSTEMS.md - Documentación de sistemas
- ✅ StoryBase.gd - Clase base para historias
- ✅ Constants.gd - Constantes compartidas
- ✅ STORY_STATE.md (Violet Evergarden)
- ✅ Documentación completa

---

# Fase 1: Sistema de Datos Desacoplados

## Objetivo
Separar contenido de código. Reemplazar arrays hardcoded por Resources reutilizables.

## Prioridad: Muy Alta

## Especificaciones

### SPEC-1.1: DialogueResource
```gdscript
class_name DialogueResource extends Resource

@export var id: String
@export var lines: Array[DialogueLine]
@export var character_name: String
@export var character_portrait: Texture2D

class DialogueLine:
	var text: String
	var conditions: Dictionary
	var next_dialogue: String
```

### SPEC-1.2: CharacterResource
```gdscript
class_name CharacterResource extends Resource

@export var id: String
@export var name: String
@export var position: Vector3
@export var dialogue_id: String
@export var traits: Dictionary
```

### SPEC-1.3: ResourceLoader
```gdscript
# core/utils/ResourceLoader.gd
func load_story_resource(story_name: String, resource_type: String, resource_id: String)
```

## Pendiente

- [ ] Crear DialogueResource.gd
- [ ] Crear CharacterResource.gd
- [ ] Crear ResourceLoader.gd
- [ ] Convertir NPC demo a CharacterResource
- [ ] Crear DialogueResource demo
- [ ] Actualizar NPC.gd para usar resources
- [ ] Crear 2-3 diálogos demo para Violet

## Resultado Esperado
- NPCs cargados desde `stories/violet_evergarden/data/characters/`
- Diálogos cargados desde `stories/violet_evergarden/data/dialogues/`
- Separación completa: contenido en `/stories/`, código en `/core/`

---

# Fase 2: Variables Narrativas Mejoradas

## Objetivo
Implementar Story Flags persistidos y diálogos condicionales.

## Prioridad: Muy Alta

## Especificaciones

### SPEC-2.1: StoryFlagSystem
- Flags almacenados en GameManager
- Cambios emiten señal GameEvents.story_flag_changed
- Documentación en STORY_STATE.md

### SPEC-2.2: Diálogos Condicionales
Cada DialogueLine puede tener `conditions`:
```gdscript
conditions = {"has_flag": "met_elder"}
```

### SPEC-2.3: Documentación de Variables
Archivo `stories/violet_evergarden/STORY_STATE.md` con todas las variables.

## Pendiente

- [ ] Implementar evaluador de condiciones
- [ ] Actualizar NPC para evaluar condiciones
- [ ] Actualizar UI para mostrar línea correcta
- [ ] Documentar todas las variables en STORY_STATE.md

## Resultado Esperado
- Diálogos cambian según story flags
- NPCs recuerdan si fueron visitados
- Narrativa ramificada funcional

---

# Fase 3: Sistema de Quests Modular

## Objetivo
Implementar quests con estados (INACTIVE, ACTIVE, COMPLETED).

## Prioridad: Muy Alta

## Especificaciones

### SPEC-3.1: QuestResource
```gdscript
class_name QuestResource extends Resource

@export var id: String
@export var title: String
@export var description: String
@export var giver_npc_id: String
@export var objective: String
@export var reward: Dictionary
@export var required_flags: Dictionary
@export var completion_flag: String
```

### SPEC-3.2: QuestManager (en GameManager)
```gdscript
var active_quests: Array[String] = []
var completed_quests: Array[String] = []

func accept_quest(quest_id: String)
func complete_quest(quest_id: String)
func is_quest_active(quest_id: String) -> bool
```

## Pendiente

- [ ] Crear QuestResource.gd
- [ ] Actualizar GameManager con QuestManager
- [ ] Implementar aceptar/completar quests
- [ ] Integrar con NPCs (ofrecer quests)
- [ ] Crear 3 quests demo para Violet

## Resultado Esperado
- NPCs pueden ofrecer quests
- Jugador puede aceptar/completar
- Completar quest actualiza story flags automáticamente

---

# Fase 4: Guardado y Persistencia

## Objetivo
Implementar SaveManager para guardar/cargar estado completo.

## Prioridad: Alta

## Especificaciones

### SPEC-4.1: SaveSystem
```gdscript
func save_game(slot: int)
func load_game(slot: int) -> bool

save_data = {
	"timestamp": Time.get_ticks_msec(),
	"story": current_story,
	"player_position": player_data["position"],
	"story_flags": story_flags,
	"active_quests": active_quests,
	"completed_quests": completed_quests,
	"world_state": world_state
}
```

## Pendiente

- [ ] Crear SaveManager.gd
- [ ] Implementar save/load
- [ ] Crear directorio saves
- [ ] Implementar UI guardar/cargar
- [ ] Testing de persistencia

## Resultado Esperado
- Guardar partida en slot
- Cargar partida anterior
- Estado completamente restaurado

---

# Fase 5: Soporte Multi-Historia

## Objetivo
Permitir crear y cargar múltiples historias sin modificar core.

## Prioridad: Alta

## Especificaciones

### SPEC-5.1: Historia como Módulo (Arquitectura Flexible)
```gdscript
class_name VioletEvergarden extends "res://core/story/StoryBase.gd"

func _ready():
	story_id = "violet_evergarden"
	story_type = "circular_world"
	setup_initial_state()
```

### SPEC-5.2: StoryLoader en GameManager
Método para cargar historias dinámicamente.

## Pendiente

- [ ] Implementar StoryBase.load_story()
- [ ] Crear VioletEvergarden como ejemplo
- [ ] Selector de historia en menú
- [ ] Testing: Cargar/cambiar historias

## Resultado Esperado
- Nuevas historias se agregan sin tocar core
- Selector permite cambiar entre historias
- Cada historia es completamente independiente

---

# Fase 6: Inventario y Objetos

## Objetivo
Sistema para obtener, usar y consumir objetos.

## Prioridad: Media (post-Fase 5)

## Especificaciones

### SPEC-6.1: ItemResource
- ID, nombre, descripción
- Tipo (consumible, equipo, quest_item)
- Efectos/usos

### SPEC-6.2: InventoryManager
- Agregar/remover items
- Usar items
- UI de inventario

## Pendiente

- [ ] Crear ItemResource.gd
- [ ] Implementar InventoryManager
- [ ] UI de inventario
- [ ] Items demo

---

# Fase 7: Cambio de Mapas

## Objetivo
Permitir transiciones entre diferentes escenas/ubicaciones.

## Prioridad: Media (post-Fase 5)

## Especificaciones

### SPEC-7.1: WorldLoader
- Cargar escena siguiente
- Persisterencia de estado entre mapas
- Puntos de entrada (spawn points)

### SPEC-7.2: Portales/Puertas
- Áreas de trigger para cambio de mapa
- Transiciones suaves

## Pendiente

- [ ] Crear WorldLoader
- [ ] Crear sistema de portales
- [ ] Escenas adicionales para Violet
- [ ] Testing de transiciones

---

# Fase 8: Animaciones y Mundo Vivo

## Objetivo
Agregar animaciones, NPCs que se mueven, ciclo día/noche.

## Prioridad: Media (post-Fase 7)

**Nota:** No es prioritario. Narrativa primero, pulido después.

## Especificaciones

### SPEC-8.1: Animaciones Básicas
- Idle/Walk para jugador
- Idle/Walk para NPCs
- Transiciones suaves

### SPEC-8.2: NPCs Patrullando
- Puntos de patrulla
- Comportamiento AI simple
- Estados (idle, walk, interact)

### SPEC-8.3: Ciclo Día/Noche
- Iluminación dinámica
- NPCs con horarios
- Story flags basadas en hora

## Pendiente

- [ ] Crear animaciones modelo jugador
- [ ] Crear animaciones modelo NPC
- [ ] Implementar AnimationController
- [ ] Implementar sistema de patrullas
- [ ] Implementar ciclo día/noche

---

# Fase 9: Vertical Slice Completo

## Objetivo
Experiencia completa jugable de principio a fin.

## Prioridad: Alta (después de Fase 7)

## Flujo Esperado

```
1. Menú principal
2. Seleccionar historia (Violet Evergarden)
3. Jugar: Hablar con NPC → Recibir quest → Completar → Recompensa
4. Guardar/Cargar funcional
5. Créditos y conclusión emocional
```

## Pendiente

- [ ] Menú principal
- [ ] Selector de historia
- [ ] Menú pausa
- [ ] UI guardar/cargar
- [ ] Créditos finales
- [ ] Testing completo

## Resultado Esperado
- Juego funcional de principio a fin
- Experiencia pulida
- Ready para demo/release

---

# Fase 10: Sistema de Combate (FUTURE)

## Estado: 🚫 NO PLANEADO

**Nota:** Sistema de combate está explícitamente OUT OF SCOPE.

El enfoque del motor es **narrativa**, no combate. Si se implementa algún día, será:
- Turn-based simple
- Opcional para historias
- Post-Fase 9 (mucho después)

---

# Fases Descartadas (No Implementar)

- ❌ Multiplayer
- ❌ Crossplay  
- ❌ MMO
- ❌ IA generativa
- ❌ Editor visual de historias
- ❌ Procedural generation

Estas mantienen el proyecto enfocado en narrativa escalable.

---

# Timeline Estimado

| Fase | Estimado | Prioridad |
|------|----------|-----------|
| 0 | ✅ DONE | - |
| 1 | 1 semana | Muy Alta |
| 2 | 1 semana | Muy Alta |
| 3 | 1 semana | Muy Alta |
| 4 | 3-4 días | Alta |
| 5 | 3-4 días | Alta |
| 6 | 1 semana | Media |
| 7 | 1 semana | Media |
| 8 | 2 semanas | Media |
| 9 | 1-2 semanas | Alta |
| 10 | Never | - |

**Total estimado:** 10-12 semanas (3 meses)

---

# Cómo Contribuir

1. Lee ARCHITECTURE.md
2. Entiende Specification-Driven Development
3. Escribe SPEC antes de código
4. Mantén separación `/core/` ≠ `/stories/`
5. Documenta decisiones en ARCHITECTURE.md
6. Actualiza este roadmap

---

# Notas Importantes

## Spec-Driven Development
Antes de implementar cualquier feature:
1. Escribir especificación (SPEC-X.Y)
2. Definir estructura/interfaz
3. Implementar
4. Documentar
5. Testing

## Separación Core/Stories
- **`/core/`** = Motor reutilizable (cambios requieren revisión)
- **`/stories/`** = Contenido específico (cambios libres)

## Documentación Viva
- ARCHITECTURE.md se actualiza con cada decisión importante
- SYSTEMS.md documenta API de cada sistema
- STORY_STATE.md documenta variables de cada historia

---

# Referencias

- [ARCHITECTURE.md](./nuevo-proyecto-de-juego/docs/ARCHITECTURE.md)
- [SYSTEMS.md](./nuevo-proyecto-de-juego/docs/SYSTEMS.md)
- [STORY_TEMPLATE.md](./nuevo-proyecto-de-juego/docs/STORY_TEMPLATE.md)
- [CURRENT_STATE.md](./CURRENT_STATE.md)

---

**Versión:** 0.1.0  
**Estado:** Fase 0 ✅ / Fase 1 ⏳  
**Motor:** Godot 4.6.3  
**Metodología:** Specification-Driven Development
