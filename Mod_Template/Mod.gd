extends Node2D # change this to whatever type of node this is placed on

export var mod_file : Resource # the mods resource file
var gameLocation = OS.get_executable_path().get_base_dir()

export var Resource_Name : String

var mod_name
var mod_author
var mod_version

# loading the mod properties
func _ready():
	
	mod_file = load(str(gameLocation) + "/boneLoader/" + Resource_Name + ".tres") # getting the mods resource
	
	# settings the mods variables
	mod_name = mod_file.get("mod_name")
	mod_author = mod_file.get("mod_author")
	mod_version = mod_file.get("mod_version")
