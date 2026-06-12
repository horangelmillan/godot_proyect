# Estado de Historia - Violet Evergarden

Última actualización: 2026-06-12

---

## Propósito

Esta es la historia piloto del motor. Basada en el anime "Violet Evergarden", recrea la esencia de ayudar a otros a través de la escritura de cartas emocionales.

El jugador es un asistente postal que ayuda a Violet a entregar cartas especiales mientras aprende sobre la importancia de la comunicación y los sentimientos.

**Duración esperada:** 2-3 horas (para vertical slice)

---

## Acto I: El Encuentro

**Escenas:**
1. Plaza del pueblo (intro)
2. Oficina de correos (Violet)
3. Casa del cliente (objetivo de entrega)

**Conflicto:** Violet necesita ayuda para encontrar al destinatario.

---

## Variables Narrativas (Story Flags)

### Conocimiento de Personajes
- `met_violet` (bool) - ¿Conoce a Violet?
- `violet_likes_player` (int) - Nivel de amistad (0-100)
- `met_hodgins` (bool) - ¿Conoce al supervisor postal?

### Progreso de Quests
- `main_quest_active` (bool) - ¿Se activó misión principal?
- `letter_delivery_1_active` (bool)
- `letter_delivery_1_completed` (bool)
- `letter_delivery_2_active` (bool)
- `letter_delivery_2_completed` (bool)

### Estado del Mundo
- `visited_locations` (Array[String])
  - "plaza"
  - "post_office"
  - "client_house"
- `npcs_met` (Array[String])
  - "violet"
  - "hodgins"
  - "client_1"

### Emociones del Jugador
- `player_wisdom` (int) - 0-100, aumenta con cada carta entregada
- `letters_delivered_total` (int) - Contador de cartas

---

## Personajes Principales

### Violet Evergarden
- **Rol:** Protagonista, escritora de cartas
- **Descripción:** Joven talentosa que escribe cartas emocionales. Necesita ayuda para encontrar destinatarios.
- **Diálogos:** Diferentes según `violet_likes_player`

### Hodgins
- **Rol:** Supervisor postal
- **Descripción:** Gerente de la oficina de correos. Ofrece quests.

### Client 1
- **Rol:** Cliente que necesita carta
- **Descripción:** Anciano que quiere reconectar con su familia

---

## Escenas

- `scenes/main_plaza.tscn` - Primera ubicación, tutorial
- `scenes/post_office.tscn` - Oficina de Violet
- `scenes/client_house.tscn` - Casa del cliente

---

## Diálogos Clave

### Violet - Primer encuentro
**Condición:** `!met_violet`
```
Violet: "¿Hola? ¿Buscas algo?"
Player: "¿Eres Violet?"
Violet: "Sí, soy yo. ¿Necesitas algo especial?"
```
**Efecto:** `set_story_flag("met_violet", true)`

### Violet - Después de conocer
**Condición:** `met_violet && letter_delivery_1_completed`
```
Violet: "Gracias por tu ayuda. Ese cliente estaba muy feliz."
Player: "¿Puedo ayudarte con más cartas?"
Violet: "Si te animas... siempre hay más historias que contar."
```

---

## Misiones

### Main Quest 1: "Ayuda a Violet"
- **Giver:** Violet
- **Objetivo:** Entrega 3 cartas para aprender el oficio
- **Rewards:** +50 wisdom, +100 gold
- **Completion Flag:** `main_quest_1_completed`

### Side Quest: "Carta para la Familia"
- **Giver:** Cliente
- **Objective:** Escuchar la historia del cliente y entregar su carta
- **Rewards:** +30 wisdom, +50 gold
- **Completion Flag:** `side_quest_family_letter_completed`

---

## Flujo Esperado (Vertical Slice)

1. Jugador aparece en plaza
2. Puede explorar libremente
3. Habla con Violet → recibe main quest
4. Visita casa del cliente → recibe carta
5. Entrega carta → completa quest
6. Vuelve a Violet → recibe recompensa y nuevo quest
7. Ciclo 2 más veces
8. Créditos (Fase 9)

---

## Notas Técnicas

- **Punto de entrada:** `scenes/main_plaza.tscn`
- **Primera escena:** Cargada automáticamente desde `Main.tscn`
- **NPCs:** Instanciados en escenas específicas
- **Diálogos:** Referenciados desde `data/dialogues/` (Fase 1)
- **Sistema de guardado:** Solo posición + flags (sin cargas, armas, etc.)

---

## Versión Actual

**MVP (Fase 0):** 
- ✅ Escena principal
- ✅ Diálogos hardcoded
- ✅ Movimiento del jugador
- ✅ GameManager centralizado

**TODO (Fase 1+):**
- [ ] DialogueResource
- [ ] QuestResource
- [ ] Story flags condicionales
- [ ] Cambio de mapas
- [ ] Guardado real
- [ ] Animaciones

---

## Para el Siguiente Desarrollador

1. Leer `ARCHITECTURE.md` para entender la estructura
2. Cualquier nuevo NPC debe heredar de `core/systems/dialogue/npc.gd`
3. Nuevos diálogos van en `data/dialogues/` como resources (Fase 1)
4. Actualizar este archivo si hay cambios narrativos
5. Documentar nuevos story flags aquí antes de implementarlos

---

## Referencias

- Inspiración: Anime "Violet Evergarden" (2018)
- Plataforma: Godot 4.6.3
- Metodología: Specification-Driven Development
