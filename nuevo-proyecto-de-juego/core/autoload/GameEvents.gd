extends Node

signal story_flag_changed(flag_name: String, value: bool)
signal quest_accepted(quest_id: String)
signal quest_completed(quest_id: String)
signal dialogue_started(dialogue_id: String)
signal dialogue_ended()
signal npc_visited(npc_id: String)
signal location_visited(location_id: String)
signal game_saved()
signal game_loaded()
signal player_moved(position: Vector3)
