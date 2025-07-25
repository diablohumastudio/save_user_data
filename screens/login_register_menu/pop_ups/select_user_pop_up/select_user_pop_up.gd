class_name SelectUserPopUp extends Control

var new_button_group: ButtonGroup = ButtonGroup.new()

func _ready() -> void:
	var users_credentials: AllUsersCredentials = UDS.get_property(UDS.PROPERTIES.USERS_CREDENTIALS)
	for child in %UsersContainer.get_children():
		child.queue_free()
	for ii in users_credentials.credentials.size():
		var user_credentials: UserCredentials = users_credentials.credentials[ii]
		var new_select_user_btn: SelectUserBtn = load("res://screens/login_register_menu/pop_ups/select_user_pop_up/select_user_btn/select_user_btn.tscn").instantiate()
		new_select_user_btn.user_credentials = user_credentials
		new_select_user_btn.button_group = new_button_group
		new_select_user_btn.pressed.connect(_on_select_user_btn_pressed)
		if ii == users_credentials.current_user_index:
			new_select_user_btn.button_pressed = true
		%UsersContainer.add_child(new_select_user_btn)

func _on_select_user_btn_pressed():
	%AceptBtn.show()
	%CloseBtn.hide()

func _on_close_btn_pressed() -> void:
	hide()

func _on_acept_btn_pressed() -> void:
	SMS.change_scene(GC.SCREENS_UIDS.WELCOME_MENU)
