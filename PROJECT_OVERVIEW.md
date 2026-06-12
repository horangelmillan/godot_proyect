# RPG PixelArt 3D

## Visión del Proyecto

Crear un RPG narrativo inspirado en títulos clásicos como:

* Pokémon HeartGold / SoulSilver
* Pokémon de Nintendo DS
* Zelda Spirit Tracks
* Golden Sun
* JRPG clásicos

El objetivo es construir un mundo estilizado tipo chibi en 3D con fuerte enfoque narrativo y emocional.

La prioridad principal es la historia, la exploración y las interacciones con NPCs.

El combate no es actualmente una prioridad y será diseñado en una fase posterior.

---

# Filosofía de Desarrollo

Este proyecto sigue un enfoque Specification-Driven Development.

Antes de implementar nuevas funcionalidades se definen:

* Estado actual
* Objetivos
* Arquitectura
* Alcance
* Restricciones

Cada nueva sesión de desarrollo debe partir del estado documentado.

---

# Principios

## Priorizar Vertical Slice

Primero:

Jugador
→ Habla con NPC
→ Recibe misión
→ Completa misión
→ Obtiene recompensa
→ Guarda partida

Antes de:

* MMO
* Multiplayer
* IA generativa
* Procedural Generation
* Sistemas complejos

---

## Datos separados del código

A largo plazo:

Contenido ≠ Código

Los diálogos, misiones, NPCs y objetos deben existir como recursos de datos independientes.

---

## Escalabilidad

La arquitectura debe permitir en el futuro:

* Herramientas de creación de historias
* Generación de NPCs mediante IA
* Generación de diálogos mediante IA
* Generación de contenido procedural

Sin necesidad de reescribir sistemas principales.

---

# Tecnologías

## Motor

Godot 4.x

## Lenguaje

GDScript

## Control de versiones

Git

GitHub

---

# Ideas Futuras (NO IMPLEMENTAR AÚN)

* Sistema de combate
* Multiplayer
* Crossplay
* MMO
* IA generativa
* Editor de historias
* Generación procedural de mapas
* Generación procedural de NPCs

Estas características están explícitamente fuera del alcance actual.
