# core/story/StoryBase.gd
# Clase base para todas las historias
# Cada historia debe heredar de StoryBase e implementar su propia lógica

extends Node

class_name StoryBase

var story_id: String = "unnamed_story"
var story_type: String = "generic"  # circular_world, dungeon, city, etc.

func _ready() -> void:
    pass

func load_characters() -> void:
    # Implementar en subclases
    pass

func load_scenes() -> void:
    # Implementar en subclases
    pass

func setup_initial_state() -> void:
    # Implementar en subclases
    pass

func load_world() -> void:
    # Implementar en subclases
    pass
