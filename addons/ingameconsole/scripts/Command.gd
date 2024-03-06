class_name Command

var name: String
var callable: Callable
var arg_count: int
var description: String
var arg_names: Array[String]

func _init(_name:String, _callable:Callable, _arg_names:Array[String], _description:String):
	self.name = _name.to_lower()
	self.callable = _callable
	self.arg_names = _arg_names
	self.description = _description

func INVOKE(args:Array[String] = []):
	var arg_dict: Dictionary = {}
	if (arg_names.size() != args.size()):
		if (ProjectSettings.get_setting("_global_script_classes").has("GameConsole")): 
			ProjectSettings.get_setting("_global_script_classes")["GameConsole"].log_error("Command needs " + str(arg_names.size()) + " arguments but recieved " + str(args.size()) + ".")
		return
	else:
		for i in args.size():
			arg_dict[arg_names[i]] = args[i]
	
	if arg_dict.size() == 0:
		callable.call()
		return
	else:
		callable.call(arg_dict)
