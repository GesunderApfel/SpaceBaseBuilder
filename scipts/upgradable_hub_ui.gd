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
@onready var upgradable_levels = $Control/Panel/PanelContainer/Upgradable_Levels
@onready var texture_button = $Control/Panel/TextureButton


const HUB_UPGRADABLE_LEVEL_UI = preload("res://scenes/base_building/hub_upgrade_level_ui.tscn")


func _ready():
	building_name_label.text = building_name
	
	var upgradable_level_ui = HUB_UPGRADABLE_LEVEL_UI.instantiate()
	upgradable_level_ui.init_manually()
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
	
	
	texture_button.texture_normal = upgradable_container.attribute_icon
	if upgradable_container.is_buyable(current_level):
		texture_button.texture_hover = upgradable_container.attribute_icon_sucess
	else:
		texture_button.texture_hover = upgradable_container.attribute_icon_failure
	
	
	upgradable_levels.add_child(upgradable_level_ui)
	
	debug_log_all_upgradables()
	pass

func debug_log_all_upgradables():
	for c in upgradable_container.upgradables_list:
		var format_string = "Level %s | Cost: %s | Value: %s"
		print(format_string % [c.level, c.cost, c.value])
		
