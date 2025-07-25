class_name Level extends Resource

enum IDs {Level1, Level2, Level2p, Level3, LevelEx, LevelEx2, Level4}

@export var id: IDs
@export var level_name: String
@export var ud_level: UDLevel : set = _set_ud_level

func _set_ud_level(new_value:UDLevel) -> void:
	ud_level = new_value
	for saved_ud_lv in UDS.current_user_data.progress.ud_levels:
		if saved_ud_lv.id == ud_level.id:
			ud_level = saved_ud_lv
