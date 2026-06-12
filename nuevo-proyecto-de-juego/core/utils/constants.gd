# core/utils/constants.gd
# Constantes compartidas del motor

extends Node

class_name GameConstants

# Velocidades
const PLAYER_SPEED = 5.0
const PLAYER_JUMP_VELOCITY = 2.0
const CAMERA_FOLLOW_SPEED = 5.0

# Distancias
const INTERACTION_DISTANCE = 1.5

# Paths
const SAVES_DIR = "user://saves/"
const STORIES_PATH = "res://stories/"
const RESOURCES_PATH = "res://stories/{story}/data/{type}/"

# Tiempos
const TYPEWRITER_DELAY = 0.03  # segundos entre letras
const DIALOGUE_TIMEOUT = 0.1   # segundos mínimo antes de poder continuar

# Offsets de cámara
const CAMERA_EXPLORATION_OFFSET = Vector3(0, 5, 5)
const CAMERA_DIALOGUE_OFFSET = Vector3(0, 3, 3)

# Estados
enum QuestState { INACTIVE = 0, ACTIVE = 1, COMPLETED = 2 }
enum TimeOfDay { MORNING = 0, AFTERNOON = 1, NIGHT = 2 }

# Configuración de juego
const DEFAULT_STORY = "violet_evergarden"
const DEFAULT_SAVE_SLOT = 0
const MAX_SAVE_SLOTS = 10
