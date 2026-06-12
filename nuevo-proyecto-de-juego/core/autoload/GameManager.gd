extends Node

const SAVE_DIR = "user://saves/"

var current_story: String = "violet_evergarden"
var story_flags: Dictionary = {}
var player_data: Dictionary = {
	"position": Vector3.ZERO,
	"health": 100,
	"level": 1
}
var world_state: Dictionary = {
	"npcs_visited": [],
	"locations_visited": []
}
var active_quests: Array[String] = []
var completed_quests: Array[String] = []

func _ready() -> void:
	if not DirAccess.dir_exists_absolute(SAVE_DIR):
		DirAccess.make_dir_absolute(SAVE_DIR)
	load_story("violet_evergarden")

func load_story(story_id: String) -> void:
	current_story = story_id
	reset_story_state()

func reset_story_state() -> void:
	story_flags.clear()
	active_quests.clear()
	completed_quests.clear()
	world_state["npcs_visited"].clear()
	world_state["locations_visited"].clear()
	player_data["position"] = Vector3.ZERO

func set_story_flag(flag_name: String, value: bool) -> void:
	story_flags[flag_name] = value
	GameEvents.story_flag_changed.emit(flag_name, value)

func get_story_flag(flag_name: String, default_value: bool = false) -> bool:
	return story_flags.get(flag_name, default_value)

func has_story_flag(flag_name: String) -> bool:
	return story_flags.has(flag_name) and story_flags[flag_name]

func accept_quest(quest_id: String) -> void:
	if quest_id not in active_quests:
		active_quests.append(quest_id)
		GameEvents.quest_accepted.emit(quest_id)

func complete_quest(quest_id: String) -> void:
	if quest_id in active_quests:
		active_quests.erase(quest_id)
	if quest_id not in completed_quests:
		completed_quests.append(quest_id)
		GameEvents.quest_completed.emit(quest_id)

func is_quest_active(quest_id: String) -> bool:
	return quest_id in active_quests

func is_quest_completed(quest_id: String) -> bool:
	return quest_id in completed_quests

func visit_npc(npc_id: String) -> void:
	if npc_id not in world_state["npcs_visited"]:
		world_state["npcs_visited"].append(npc_id)

func visit_location(location_id: String) -> void:
	if location_id not in world_state["locations_visited"]:
		world_state["locations_visited"].append(location_id)

func save_game(slot: int) -> void:
	var save_data = {
		"timestamp": Time.get_ticks_msec(),
		"story": current_story,
		"player_position": player_data["position"],
		"story_flags": story_flags,
		"active_quests": active_quests,
		"completed_quests": completed_quests,
		"world_state": world_state
	}

	var file_path = SAVE_DIR + "save_%d.json" % slot
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	if file:
		file.store_var(save_data)

func load_game(slot: int) -> bool:
	var file_path = SAVE_DIR + "save_%d.json" % slot
	if ResourceLoader.exists(file_path):
		var file = FileAccess.open(file_path, FileAccess.READ)
		if file:
			var save_data = file.get_var()
			apply_save_data(save_data)
			return true
	return false

func apply_save_data(save_data: Dictionary) -> void:
	current_story = save_data.get("story", "violet_evergarden")
	player_data["position"] = save_data.get("player_position", Vector3.ZERO)
	story_flags = save_data.get("story_flags", {})
	active_quests = save_data.get("active_quests", [])
	completed_quests = save_data.get("completed_quests", [])
	world_state = save_data.get("world_state", {})
	GameEvents.game_loaded.emit()
