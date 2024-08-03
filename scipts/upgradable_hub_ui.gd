extends Control

@export var building_name : String = "Building Name"
@export var upgradable_container : UpgradableHubContainer

@onready var BUILDING_NAME = $Control/Panel/BuildingName


func _ready():
	BUILDING_NAME.text = building_name
	debug_log_all_upgradables()
	pass

func debug_log_all_upgradables():
	for upgrade in upgradable_container.upgradables_list:
		upgrade.resource_name
