# In Game Console for Godot 4.x

## About
A drop-in in game console that can be used in any Godot 4.x project.
*Features:*
- Logging (Basic, Debug, Warning, and Error) with customizable colors
- Commands (Builtin and Custsom), can be made or ran from any script
- Customizable theme
- Settings
- Command error checking


## Download and Install
1. Download the latset ZIP file from the releases section (or just download the source)
2. Drop the `addons/ingameconsole` folder from the ZIP into the `addons` directory of your project (or drop the whole `addons` folder if you dont already have one)
3. Open `Project Settings > Plugins` and enable the plugin
4. Ensure that either: There are two Input actions named `debug` and `accept` OR in the `GameConsole.tscn` in the inspector under 'Keybinds' that valid action names of your choice are set.
5. Play the project and press whatever key you assigned to `debug` and you are done!


## Documentation
### Builtin commands:
- list - Lists availible commands
- help <command_name> - Lists help and the description for the given command
- clear - Clears the console

### Change setings
1. Open the GameConsole scene
2. Click the root node `GameConsole`
3. Change settings in the inspector

### Register a new command
1. Open a script (Has to be attached to a node in the scene)
2. On `_ready` (or another function in `_ready`), register a new Command: 
	```
	GameConsole.register_command(
 		Command.new(
	 		"my_command",
	 		my_function,
	 		["argument_one", "argument_two"],
	 		"Description"
 		)
 	)
	```
3. Create the function: 
	```
	func my_function(args:Dictionary):
		var argument_one = args["argument_one"]
		var argument_two = args["argument_two"]

		GameConsole.log_debug(argument_one + int(argument_two))
	```
4. Run the command in the console: `my_command something 10` (Will return `[DEBUG] something 10`)
5. You can also do a command with no arguments by passing `[]` when creating the command, and omitting the `args:Dictionary` in the function.
