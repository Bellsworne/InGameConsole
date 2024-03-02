extends Control

@export_category("Settings")
@export_multiline var welcome_message: String
@export var pause_tree_when_open: bool = true
@export_subgroup("Log Colors")
@export var default_color: Color = Color.WHITE
@export var log_color: Color = Color.BLUE
@export var warning_color: Color = Color.YELLOW
@export var error_color: Color = Color.RED
@export_subgroup("Keybinds")
@export var toggle_key_action: String = "debug"
@export var enter_key_action: String = "accept"


@onready var log_label = $Panel/VBoxContainer/MarginContainer/LogLabel
@onready var input_field = $Panel/VBoxContainer/InputField

var registered_commands: Dictionary


func _ready():
	visible = false
	registered_commands.clear()
	log_label.append_text(welcome_message + "\n")
	register_builtin_commands()


func _process(delta):
	if (Input.is_action_just_pressed(toggle_key_action)):
		toggle_console()
	
	if (Input.is_action_just_pressed("accept") and input_field.has_focus()):
		submit_input()


func toggle_console():
	visible = !visible
	if (pause_tree_when_open): get_tree().paused = visible
	
	if (visible):
		input_field.grab_focus()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	input_field.clear()


func register_command(command:Command):
	if (registered_commands.has(command.name)):
		log_error("Command already registered with name: " + command.name)
		return
	else:
		registered_commands[command.name] = command


func submit_input():
	print("submit")
	if (input_field.text == ""): return
	
	print_line("> " + input_field.text)
	run_command(input_field.text)
	
	input_field.text = ""


func run_command(input:String):
	var parsed_input:Dictionary = parse_input(input)
	var command_name:String = parsed_input["name"]
	var args:Array[String] = parsed_input["args"]
	
	if (registered_commands.has(command_name)):
		if args.size() == 0:
			registered_commands[command_name].INVOKE()
		else:
			registered_commands[command_name].INVOKE(args)
	else:
		log_error("Command " + command_name + " not recognized")


func parse_input(input:String) -> Dictionary:
	input = input.to_lower()
	var input_array = input.split(' ')
	var command_name = input_array[0]
	var args: Array[String]

	for i in input_array.size():
		if i == 0: continue
		args.append(input_array[i])
	
	return {"name": command_name, "args": args}


func command_lookup(command_name:String) -> Command:
	if (registered_commands.has(command_name)):
		return registered_commands[command_name]
	else:
		log_error("No command '" + command_name + "' found.")
		return null


func print_line(message:String):
	log_label.append_text(str("[color=" + default_color.to_html(true) + "]" + message + "[/color]\n"))


func log_debug(message:String):
	log_label.append_text(str("[color=" + log_color.to_html(true) + "]" + "[LOG] " + message + "[/color]\n"))


func log_error(message:String):
	log_label.append_text(str("[color=" + error_color.to_html(true) + "]" + "[ERROR] " + message + "[/color]\n"))


func log_warning(message:String):
	log_label.append_text(str("[color=" + warning_color.to_html(true) + "]" + "[WARNING] " + message + "[/color]\n"))


func register_builtin_commands():
	register_command(Command.new("clear", clear_command, [], "Clears the console"))
	register_command(Command.new("help", help_command, ["command_name"], "Shows help for given command"))
	register_command(Command.new("list", list_command, [], "Lists all registered commands."))

func clear_command():
	log_label.clear()


func help_command(args:Dictionary):
	if (args.size() == 0 or !args.has("command_name")):
		log_error("Invalid arguments")
		return
	
	var command_name = args["command_name"]
	var command: Command = command_lookup(command_name)
	if (command == null): return
	
	print_line("-- HELP for " + command_name + " --")
	print_line(command.description)
	var args_string: String
	for name in command.arg_names:
		args_string += "[" + name + "] "
	print_line("Args: " + args_string + "\n")


func list_command():
	print_line("-- REGISTERED COMMANDS --")
	for command in registered_commands:
		print_line(command)
