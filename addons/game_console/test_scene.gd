extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	GameConsole.register_command(Command.new("test", test_command, ["my_arg"], "I am a test command"))
	

func test_command(args:Dictionary):
	GameConsole.log_debug(args["my_arg"])
