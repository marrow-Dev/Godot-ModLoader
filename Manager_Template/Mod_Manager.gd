extends Node2D


export var mod_manager : Resource

onready var mod_list = $Mod_List

var mod_location
var mods
var mods_scripts = []
var mods_resources = []
var gameLocation = OS.get_executable_path().get_base_dir()

func _ready():
	
	mods = mod_manager.get("mods")
	
	mod_location = str(gameLocation) + "/" + mod_manager.get("manager_name") + "/"
	
	load_mods(mod_location) # running the load mods function


func load_mods(path):
	var modDirectory = Directory.new() # making a new dir variable
	if modDirectory.open(path) == OK:
		modDirectory.list_dir_begin()
		print("Started M O D scan")
			
		var currentFile = modDirectory.get_next()
		while currentFile != "": # if the currentFile isn't blank
			if currentFile.begins_with("."): # if the file starts with .
				pass
				
			elif modDirectory.current_is_dir(): # if it's a directory
				
				print("Found directory: " + currentFile)
			
			elif not modDirectory.current_is_dir(): # if it's not a directory
				
				print("Found file: " + currentFile)
				
				if currentFile.ends_with(".tscn"): # if the mod is a scene
					
					var newObject = load(path + currentFile) # loading the mod
					mods.append(newObject)
				
				elif currentFile.ends_with(".gd"): # if it's a script
					mods_scripts.append(path + currentFile)
				
				elif currentFile.ends_with(".tres"): # if it's a scene
					mods_resources.append(path + currentFile)
					var mod_resource = load(path + currentFile)
					var mod_name = mod_resource.get("mod_name")
					mod_list.add_item(mod_name)
					
				else:
					print("Found other file: " + currentFile)
					
			currentFile = modDirectory.get_next()
			
		modDirectory.list_dir_end()
	
		var counted = 0
		
		for mod in mods:
			mod.script = mods_scripts[counted]
			print("Loaded script")
			counted += 1
	
	else:
		print("Failed to load mods!")
