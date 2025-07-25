class_name AlliesMarket extends Control

var allies: Array[Ally] = DataFilesLoader.get_allies_from_res_files()

func _ready() -> void:
	for child in %MAPContainer.get_children():
		child.queue_free()
	for ally in allies:
		var new_ally_presenter: MarketAllyPresenter = load("res://screens/allies_market/market_ally_presenter/market_ally_presenter.tscn").instantiate()
		new_ally_presenter.ally = ally
		new_ally_presenter.ally_details_requested.connect(_on_ally_details_requested)
		%MAPContainer.add_child(new_ally_presenter)

func _on_ally_details_requested(ally: Ally) -> void:
	%AllyDetailsPopup.ally = ally
	%AllyDetailsPopup.show()

func _on_go_back_btn_pressed() -> void:
	SMS.change_scene(GC.SCREENS_UIDS.MENU)

func _on_present_unlocked_allies_button_pressed() -> void:
	var text_to_present: String = ""
	for ally in allies:
		for ally_level in ally.ud_ally.unlocked_levels:
			text_to_present = text_to_present + str(ally.ally_name) + "is_unloked" + "\n"
	%PresentUnlockedAlliesLabel.text = text_to_present
