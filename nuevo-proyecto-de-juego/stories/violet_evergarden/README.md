# Historia: Violet Evergarden

Una adaptación interactiva de la historia "Violet Evergarden" para el motor RPG narrativo.

---

## Descripción

El jugador es un asistente postal que ayuda a Violet Evergarden, una joven escritora de cartas extraordinarias, a entregar misivas emocionales a través del pueblo. A través de cada entrega, aprendes la importancia de la comunicación genuina y los sentimientos humanos.

---

## Características

- **Mecánica Principal:** Entregar cartas que conectan a las personas
- **Duración:** 2-3 horas (vertical slice)
- **Estilo:** Narrativo, emocional, contemplativo
- **NPCs:** Violet, Hodgins, Clientes
- **Ubicaciones:** 3 escenas en Fase 0

---

## Cómo Jugar

1. Ejecuta el proyecto: `F5` en Godot
2. Usa `WASD` para mover el personaje
3. Presiona `E` cerca de NPCs para hablar
4. Lee los diálogos y sigue las instrucciones
5. Entrega cartas y completa quests

---

## Progreso Fase 0

✅ Estructura de carpetas creada  
✅ STORY_STATE.md documentado  
✅ GameManager integrado  
✅ NPC base (`core/systems/dialogue/npc.gd`) disponible  

⏳ DialogueResource (Fase 1)  
⏳ QuestResource (Fase 3)  
⏳ Cambio de mapas (Fase 7)  
⏳ Guardado real (Fase 4)  

---

## Estructura

```
stories/violet_evergarden/
├── data/
│   ├── characters/     # NPCs (Violet, Hodgins, etc.)
│   ├── dialogues/      # Líneas de diálogo
│   ├── quests/         # Misiones
│   └── world_config.gd # Configuración de mundo
├── scenes/
│   ├── main_plaza.tscn
│   ├── post_office.tscn
│   └── client_house.tscn
├── STORY_STATE.md      # Variables narrativas
└── README.md           # Este archivo
```

---

## Personajes

### Violet Evergarden
- Protagonista, escritora de cartas
- Ubicación: Oficina de Correos
- Necesita ayuda para encontrar destinatarios

### Hodgins
- Supervisor de la oficina postal
- Ofrece recompensas por entregas
- Mentor del jugador

### Cliente 1, 2, 3
- Personas que necesitan cartas
- Cada uno tiene una historia única
- Aparecen en diferentes ubicaciones

---

## Misiones Principales

### Quest 1: "El Primer Encuentro"
- Hablar con Violet
- Recibir explicación de la mecánica
- Aceptar primer trabajo

### Quest 2-4: "Entregas de Cartas"
- Recibir carta del cliente
- Encontrar al destinatario
- Entregar carta
- Recompensa: +wisdom, +gold

### Final: "Créditos" (Fase 9)
- Conclusión emocional
- Resumen de impacto
- Despedida de personajes

---

## Notas de Desarrollo

### Para Expandir la Historia (Fase 5+)

1. **Más NPCs:** Agregar personajes en `data/characters/`
2. **Más Ubicaciones:** Crear escenas en `scenes/`
3. **Más Quests:** Crear resources en `data/quests/`
4. **Animaciones:** Agregar anims cuando llegue Fase 8
5. **Cambio de Mapas:** Implementar transiciones en Fase 7

### Bug Tracking

Si encuentras un bug:
1. Documenta qué hiciste
2. ¿Es reproducible?
3. Abre issue con detalles
4. Incluye logs de Godot

### Testing Manual

```
1. Ejecutar proyecto
2. Mover jugador: WASD ✓
3. Saltar: Espacio ✓
4. Interactuar con NPC: E ✓
5. Ver diálogo aparecer ✓
6. Avanzar diálogo: E ✓
7. Cerrar diálogo ✓
8. Mover de nuevo ✓
```

---

## Roadmap de Violet Evergarden

| Feature | Fase | Estado |
|---------|------|--------|
| Escena Principal | 0 | ✅ |
| Diálogos Básicos | 0 | ✅ |
| Movimiento | 0 | ✅ |
| Resources (DialogueResource) | 1 | ⏳ |
| Quests | 3 | ⏳ |
| Guardado Real | 4 | ⏳ |
| Más Ubicaciones | 7 | ⏳ |
| Animaciones | 8 | ⏳ |
| Conclusión Completa | 9 | ⏳ |

---

## Cómo Contribuir a Esta Historia

1. Lee `STORY_STATE.md` para entender las variables
2. Si agregas NPC nuevo, documenta sus flags
3. Si agregas quest nueva, actualiza STORY_STATE.md
4. Mantén datos en `data/` separados de código en `core/`
5. Testing: Verifica que todo funciona

---

## FAQ

**P: ¿Por qué Violet aparece solo en Fase 0?**  
R: Es un vertical slice. Fase 1+ agregarán más content.

**P: ¿Puedo cambiar los diálogos?**  
R: Sí. En Fase 0 están hardcoded en `core/systems/dialogue/npc.gd`. En Fase 1 usarán DialogueResource para fácil edición.

**P: ¿Cómo agrego una ubicación nueva?**  
R: Crea `scenes/new_location.tscn` y úsalo desde otra escena (Fase 7).

---

## Referencias

- [ARCHITECTURE.md](../../docs/ARCHITECTURE.md) - Motor
- [STORY_STATE.md](./STORY_STATE.md) - Variables de estado
- [SYSTEMS.md](../../docs/SYSTEMS.md) - Documentación de sistemas
- Anime original: Violet Evergarden (2018)

---

**Versión:** 0.1.0  
**Última actualización:** 2026-06-12  
**Motor:** Godot 4.6.3  
**Etapa:** Fase 0 - Vertical Slice
