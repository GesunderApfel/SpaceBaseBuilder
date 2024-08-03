extends Node3D

enum BuildingType{
	BASE,
	ENERGY,
	DEPOT,
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
	
	levels[0] = level_1
	levels[1] = level_2
	levels[2] = level_3
	levels[3] = level_4
	levels[4] = level_5
		
	var current_level = 0
	
	match building_type:
		BuildingType.BASE:
			current_level = HubState.hub_base_level
		BuildingType.ENERGY:
			current_level = HubState.hub_energy_level
		BuildingType.DEPOT:
			current_level = HubState.hub_depot_level
		
	for i in current_level:
		upgrade()
	
	
func upgrade():
	if upgrade_type == UpgradeType.ADDITIONAL:
		levels[current_level].show()
	else:
		levels[current_level].show()
		if current_level > 0:
			levels[current_level-1].hide()

