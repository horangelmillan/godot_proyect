# Estado Actual del Proyecto

Última actualización: 2026-06-12

---

# Fase 0: ✅ COMPLETADA

## Arquitectura Base Implementada

### GameManager (Autoload)
- ✅ Estado centralizado
- ✅ Story flags
- ✅ Gestión de quests
- ✅ Sistema de guardado básico
- **Ubicación:** `core/autoload/GameManager.gd`

### GameEvents (Autoload)
- ✅ Señales globales
- ✅ Comunicación desacoplada
- **Ubicación:** `core/autoload/GameEvents.gd`

### Estructura de Carpetas
- ✅ `/core/autoload/` - Autoloads
- ✅ `/core/systems/` - Sistemas modulares
- ✅ `/core/utils/` - Utilidades
- ✅ `/stories/violet_evergarden/` - Historia piloto
- ✅ `/docs/` - Documentación

### Scripts Refactorizados a Nueva Estructura
- ✅ `player.gd` → `core/systems/player/player_controller.gd`
- ✅ `camera_3d.gd` → `core/systems/camera/camera_controller.gd`
- ✅ `npc.gd` → `core/systems/dialogue/npc.gd`
- ✅ `ui.gd` → `core/systems/ui/dialogue_ui.gd`

### Documentación Creada
- ✅ `ARCHITECTURE.md` - Decisiones arquitectónicas
- ✅ `STORY_TEMPLATE.md` - Guía para nuevas historias
- ✅ `SYSTEMS.md` - Documentación de sistemas
- ✅ `README.md` - Visión general del proyecto
- ✅ `STORY_STATE.md` - Variables de Violet Evergarden
- ✅ `stories/violet_evergarden/README.md` - Documentación de historia

### Main.tscn
- ✅ Referencias actualizadas a nuevos paths
- ✅ Autoloads registrados
- ✅ Funcional sin errores

---

# Sistemas Actuales

## Jugador
Completado en Fase 0:
- ✅ Movimiento WASD
- ✅ Gravedad 3D
- ✅ Saltos
- ✅ Interacción con NPCs (distancia)
- ✅ Bloqueo durante diálogos
- ✅ Integración con GameManager

## Cámara
Completado en Fase 0:
- ✅ Seguimiento del jugador
- ✅ Movimiento suave (lerp)
- ✅ Modo exploración
- ✅ Modo diálogo (zoom)
- ✅ LookAt automático

## NPC
Completado en Fase 0:
- ✅ Sistema de interacción
- ✅ Distancia de interacción
- ✅ Mirar al jugador
- ✅ ID único para tracking
- ✅ Integración con GameManager

## Diálogos
Completado en Fase 0:
- ✅ Apertura/cierre
- ✅ Múltiples líneas
- ✅ Avance con tecla E
- ✅ Máquina de escribir (0.03s/letra)
- ✅ Transición de cámara
- ✅ Bloqueo de movimiento

---

# Próximas Fases

## Fase 1: Sistema de Datos Desacoplados

**Objetivos:**
- DialogueResource (reemplaza arrays hardcoded)
- CharacterResource (define NPCs)
- ResourceLoader (carga desde stories/)

**Estado:** PENDING

---

## Fase 2: Variables Narrativas Mejoradas

**Objetivos:**
- Story flags persistidos
- Diálogos condicionales
- Documentación de variables

**Estado:** PENDING

---

## Fase 3: Sistema de Quests

**Objetivos:**
- QuestResource
- Estados (INACTIVE, ACTIVE, COMPLETED)
- Integración con NPCs

**Estado:** PENDING

---

## Fase 4: Guardado y Persistencia

**Objetivos:**
- SaveManager
- Múltiples slots
- Persistencia completa

**Estado:** PENDING

---

## Fase 5: Soporte Multi-Historia

**Objetivos:**
- StoryBase funcional
- Cargar historias dinámicamente
- Selector de historia

**Estado:** PENDING

---

# Restricciones Actuales (Intencionales)

Los siguientes sistemas NO existen en Fase 0 (planeado para fases posteriores):

- ❌ Diálogos como Resources (Fase 1)
- ❌ Quests (Fase 3)
- ❌ Guardado real (Fase 4)
- ❌ Cambio de mapas (Fase 7)
- ❌ Inventario (Fase 6)
- ❌ Animaciones (Fase 8)
- ❌ Sistema de combate (Fase 10/Never)

---

# Estructura de Carpetas Final

```
res://
├── core/
│   ├── autoload/
│   │   ├── GameManager.gd ✅
│   │   └── GameEvents.gd ✅
│   ├── systems/
│   │   ├── dialogue/
│   │   │   └── npc.gd ✅
│   │   ├── player/
│   │   │   └── player_controller.gd ✅
│   │   ├── camera/
│   │   │   └── camera_controller.gd ✅
│   │   ├── ui/
│   │   │   └── dialogue_ui.gd ✅
│   │   ├── quest/ ⏳
│   │   └── save/ ⏳
│   ├── utils/
│   │   └── constants.gd ✅
│   └── story/
│       └── StoryBase.gd ✅
│
├── stories/
│   └── violet_evergarden/
│       ├── data/
│       │   ├── characters/ ⏳
│       │   ├── dialogues/ ⏳
│       │   ├── quests/ ⏳
│       │   └── world_config.gd ⏳
│       ├── scenes/ ⏳
│       ├── STORY_STATE.md ✅
│       └── README.md ✅
│
├── docs/
│   ├── ARCHITECTURE.md ✅
│   ├── STORY_TEMPLATE.md ✅
│   └── SYSTEMS.md ✅
│
├── assets/
├── saves/
├── Main.tscn ✅
├── project.godot ✅
└── README.md ✅
```

---

# Próximas Acciones (Fase 1)

1. Crear DialogueResource.gd
2. Crear CharacterResource.gd
3. Crear ResourceLoader.gd
4. Convertir NPC hardcoded a resources
5. Crear primera DialogueResource demo
6. Actualizar NPC.gd para usar resources

---

# Notas de Desarrollo

## Tecnología
- Godot 4.6.3
- GDScript
- Git para versionado
- Spec-Driven Development

## Decisiones Arquitectónicas
1. **Centralizar estado en GameManager** - Reemplaza get_tree().get_first_node_in_group()
2. **Separar /core/ y /stories/** - Máxima reutilización
3. **Documentación viva** - ARCHITECTURE.md, SYSTEMS.md actualizados con código
4. **Spec-Driven Development** - Especificaciones antes de código

## Deuda Técnica
- Diálogos hardcoded (será reemplazado por DialogueResource en Fase 1)
- NPC estático en Main.tscn (será cargado desde resources en Fase 5)
- Sin guardado real (será implementado en Fase 4)

---

**Versión:** 0.1.0  
**Estado Global:** Fase 0 ✅ COMPLETA / Fase 1 ⏳ PENDING  
**Motor:** Godot 4.6.3  
**Metodología:** Specification-Driven Development
