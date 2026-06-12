# Motor RPG Narrativo - Chibi-PixelArt

Un motor de juego RPG reutilizable construido en Godot 4.6.3 para crear historias narrativas estilo chibi-pixelart, inspiradas en Pokémon SoulSilver, Zelda Spirit Tracks y Final Fantasy DS.

---

## Visión

Crear un motor escalable que permita **recrear historias de anime (como Violet Evergarden) en forma de juegos interactivos**, con énfasis en:
- **Narrativa emocional** sobre combate
- **Mundos circulares** reutilizables
- **Múltiples historias** usando el mismo motor
- **Datos separados del código** para máxima flexibilidad

---

## Características Actuales (Fase 0)

✅ **Arquitectura Centralizada**
- GameManager para estado global
- GameEvents para comunicación desacoplada
- Estructura modular (`/core`, `/stories`)

✅ **Sistema de Diálogos**
- Máquina de escribir
- Bloqueo de movimiento durante diálogos
- Transiciones de cámara

✅ **Movimiento del Jugador**
- WASD + Gravedad 3D
- Saltos
- Interacción con NPCs

✅ **Documentación Viva**
- ARCHITECTURE.md - Decisiones arquitectónicas
- STORY_TEMPLATE.md - Guía para nuevas historias
- SYSTEMS.md - Documentación de cada sistema

---

## Estructura del Proyecto

```
nuevo-proyecto-de-juego/
├── core/                   # Motor reutilizable
│   ├── autoload/          # GameManager, GameEvents
│   ├── systems/           # Sistemas modularizados
│   ├── utils/             # Utilidades compartidas
│   └── story/             # Clase base para historias
│
├── stories/               # Contenido específico
│   └── violet_evergarden/ # Historia piloto
│
├── docs/                  # Documentación
│   ├── ARCHITECTURE.md
│   ├── STORY_TEMPLATE.md
│   └── SYSTEMS.md
│
├── assets/                # Modelos, texturas, audio
├── saves/                 # Archivos de guardado
└── Main.tscn
```

---

## Cómo Empezar

### 1. Clonar y Abrir

```bash
git clone <repo-url>
cd nuevo-proyecto-de-juego
# Abrir en Godot 4.6.3
```

### 2. Leer la Documentación

1. **ARCHITECTURE.md** - Entiende la estructura
2. **SYSTEMS.md** - Lee sobre cada sistema
3. **STORY_STATE.md** - Lee la historia piloto

### 3. Ejecutar el Proyecto

```
F5 en Godot para ejecutar
WASD para mover
E para interactuar
```

### 4. Crear tu Propia Historia

Sigue el template en **docs/STORY_TEMPLATE.md**

---

## Roadmap

| Fase | Objetivo | Estado |
|------|----------|--------|
| 0 | Arquitectura base | ✅ DONE |
| 1 | Datos desacoplados (Resources) | ⏳ PENDING |
| 2 | Variables narrativas mejoradas | ⏳ PENDING |
| 3 | Sistema de quests | ⏳ PENDING |
| 4 | Guardado y persistencia | ⏳ PENDING |
| 5 | Soporte multi-historia | ⏳ PENDING |
| 6 | Inventario | ⏳ PENDING |
| 7 | Cambio de mapas | ⏳ PENDING |
| 8 | Animaciones y mundo vivo | ⏳ PENDING |
| 9 | Vertical slice completo | ⏳ PENDING |
| 10 | Sistema de combate | 🚫 FUTURE |

---

## Tecnologías

- **Motor:** Godot 4.6.3
- **Lenguaje:** GDScript
- **Filosofía:** Specification-Driven Development (SDD)
- **Control de versiones:** Git

---

## Metodología

### Specification-Driven Development (SDD)

Antes de implementar:
1. Escribir especificación (SPEC-X.Y)
2. Definir datos/estructura
3. Implementar código
4. Documentar
5. Testing

Esto asegura que cada feature sea escalable y reutilizable.

---

## Guía Rápida: Crear una Historia

### Paso 1: Crear carpeta
```bash
mkdir -p stories/mi_historia/{data/{characters,dialogues,quests},scenes}
```

### Paso 2: Documentar en STORY_STATE.md
```markdown
# Estado de Historia - Mi Historia
[Documentar variables narrativas]
```

### Paso 3: Crear world_config.gd
```gdscript
extends "res://core/story/StoryBase.gd"

func _ready():
    story_id = "mi_historia"
    setup_initial_state()
```

### Paso 4: Crear escenas y NPCs
- Crear escenas en `scenes/`
- Colocar NPCs con el script `core/systems/dialogue/npc.gd`

### Paso 5: Testing
- Ejecutar proyecto
- Verificar que todo funciona sin modificar core

---

## Contribuir

1. Lee **ARCHITECTURE.md** antes de cambios principales
2. Mantén la separación `core/` ≠ `stories/`
3. Documenta decisiones en ADR (Architecture Decision Record)
4. Actualiza **SYSTEMS.md** si creas nuevo sistema
5. Sigue Spec-Driven Development

---

## Deuda Técnica Identificada

- **Actual:** Diálogos hardcoded. **Fase 1** los separará en DialogueResource
- **Actual:** Sin quests. **Fase 3** implementará QuestResource
- **Actual:** Sin cambio de mapas. **Fase 7** lo agregará

Estos son completamente intencionales. El roadmap mantiene el orden correcto.

---

## FAQ

**P: ¿Puedo crear múltiples historias?**  
R: Sí. Cada una va en `stories/nombre_historia/` completamente independiente.

**P: ¿Puedo compartir NPCs entre historias?**  
R: Sí. Guarda recursos compartidos en `assets/` y referencia desde historias.

**P: ¿Debo modificar `core/`?**  
R: Solo si es un bug fix o feature que beneficia TODAS las historias. En duda, pregunta.

**P: ¿Cómo cambio de mapa?**  
R: En Fase 7. Por ahora todo sucede en Main.tscn.

**P: ¿Hay combate?**  
R: No. Es Fase 10 y puede que nunca se implemente. El énfasis es narrativa.

---

## Contacto / Issues

Para bugs, features o preguntas:
- Abre un issue en GitHub
- Sigue el template de issue

---

## Licencia

[Especificar licencia del proyecto]

---

## Inspiración

- Pokémon HeartGold / SoulSilver
- Zelda Spirit Tracks
- Final Fantasy DS
- Violet Evergarden (anime)
- Golden Sun

---

**Última actualización:** 2026-06-12  
**Versión:** 0.1.0 (Fase 0 - Arquitectura Base)  
**Godot:** 4.6.3
