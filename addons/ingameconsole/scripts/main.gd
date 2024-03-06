@tool extends EditorPlugin

const game_console_path = "res://addons/ingameconsole/GameConsole.tscn"

func _enable_plugin():
	add_autoload_singleton("GameConsole", game_console_path)

func _disable_plugin():
	remove_autoload_singleton("GameConsole")
