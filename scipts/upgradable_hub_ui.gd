extends Control

enum BuildingType{
	BASE,
	ENERGY,
	DEPOT,
}

@export var building_type : BuildingType = BuildingType.BASE
@export var building_name : String = "Building Name"
@export var upgradable_container : UpgradableHubContainer

@onready var building_name_label = $Control/Panel/BuildingName

#TODO
#const UPGRADABLE_LEVEL_UI = preload("res://scenes/base_building/upgradable_level_ui.tscn")

func hey():
	building_name_label.text = building_name
	
	var upgradable_level_ui = null#UPGRADABLE_LEVEL_UI.instantiate()
	upgradable_level_ui.texture = upgradable_container.attribute_icon
	upgradable_level_ui.name_label.text = upgradable_container.attribute_name
	
	var current_level = 0
	
	match building_type:
		BuildingType.BASE:
			current_level = HubState.hub_base_level
		BuildingType.ENERGY:
			current_level = HubState.hub_energy_level
		BuildingType.DEPOT:
			current_level = HubState.hub_depot_level
	
	upgradable_level_ui.cost_label = upgradable_container.\
		upgradables_list[current_level].cost
	upgradable_level_ui.value_label = upgradable_container\
		.upgradables_list[current_level].value
	
	self.add_child(upgradable_level_ui)
	
	debug_log_all_upgradables()
	pass

func debug_log_all_upgradables():
	for c in upgradable_container.upgradables_list:
		var format_string = "Level %s | Cost: %s | Value: %s"
		print(format_string % [c.level, c.cost, c.value])
		
