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
1. Go to the Releases page and download the latest zip.
2. In Godot, open the Asset Library, click Import and import the downloaded zip
3. Open Project setting, Autoloads, and add the `GameConsole.tscn` as GameConsole
4. Reload the project
5. Add two input actions in Project Settings, `debug` and `accept` OR change the default actions in the GameConsole settings (Open the GameConsole scene and change in the inspector)
6. Profit


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
	GameConsole.register_command(Command.new("my_command", my_function, ["argument_one", "another_two"], "Description"))
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
