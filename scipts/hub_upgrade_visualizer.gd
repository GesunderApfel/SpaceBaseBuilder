extends Node3D

enum BuildingType{
	BASE,
	ENERGY,
	DEPOT,
	DOCKS,
	RESEARCH
}

enum UpgradeType{
	SEQUENCE,
	ADDITIONAL,
}

@export var upgrade_type : UpgradeType = UpgradeType.SEQUENCE
@export var building_type : BuildingType = BuildingType.BASE

@onready var level_1 = $Level1
@onready var level_2 = $Level2
@onready var level_3 = $Level3
@onready var level_4 = $Level4
@onready var level_5 = $Level5

var levels : Array = []

var current_level = 0

func _ready():
	
	levels.append(level_1)
	levels.append(level_2)
	levels.append(level_3)
	levels.append(level_4)
	levels.append(level_5)
	
	hide_all()
	
	match building_type:
		BuildingType.BASE:
			current_level = HubState.hub_base_level
		BuildingType.ENERGY:
			current_level = HubState.hub_energy_level
		BuildingType.DEPOT:
			current_level = HubState.hub_depot_level
		BuildingType.DOCKS:
			current_level = HubState.hub_docks_level
		BuildingType.RESEARCH:
			current_level = HubState.hub_research_level
func hide_all():
	for i in levels:
		if not i == level_1: 
			i.hide()
			
	level_1.show()

func upgrade():
	current_level+=1
	if current_level >= 5:
		return
	
	if upgrade_type == UpgradeType.ADDITIONAL:
		levels[current_level].show()
	else:
		levels[current_level].show()
		levels[current_level-1].hide()

