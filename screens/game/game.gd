class_name Game extends Control

var level: Level : set = _set_level
var enemies_killed: int = 0
var canons_alive: int = GC.TOTAL_NUMBER_OF_CANONS

func _set_level(new_value: Level) -> void:
	level = new_value
	%LevelNamePresenter.text = level.level_name
	
func _ready() -> void:
	_update_kill_enemy_tot_label()
	_update_kill_enemy_label()
	UDS.listen_property(UDS.PROPERTIES.ENEMIES_KILLED, _update_kill_enemy_tot_label)

func _update_kill_enemy_tot_label():
	%KillEnemyTotalLbl.text = str(UDS.get_property(UDS.PROPERTIES.ENEMIES_KILLED)) + " enemies Killed in Total"

func _update_kill_enemy_label():
	%KillEnemyLbl.text = str(enemies_killed) + " enemies Killed in this sesion"

func _on_win_btn_pressed() -> void:
	ACS.set_action(Action.new(Action.TYPES.LV_COMPLTD_ALL_CANONS, Action.PayLvlComplAllCanons.new(level.id, canons_alive)))
	ACS.set_action(Action.new(Action.TYPES.LV_COMPLTD, Action.PayLvCompl.new(level.id)))

func _on_go_back_btn_pressed() -> void:
	SMS.change_scene(GC.SCREENS_UIDS.MENU)

func _on_kill_enemy_btn_pressed() -> void:
	enemies_killed += 1
	ACS.set_action(Action.new(Action.TYPES.ENEMY_KILLED, Action.PayEnemKilled.new(enemies_killed)))
	_update_kill_enemy_label()

func _on_canon_killed_btn_pressed() -> void:
	canons_alive -= 1
	%CanonsLeft.text = str(canons_alive) + " Canons Left"
