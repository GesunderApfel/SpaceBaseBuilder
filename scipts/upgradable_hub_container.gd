class_name UpgradableHubContainer extends Resource

@export var attribute_icon : Texture2D
@export var attribute_name: String
@export var upgradables_list : Array[UpgradableHubLevel] = []

func upgrade_level(current_level):
	
	if current_level>=upgradables_list.size():
		push_error("Upgrade level already above maximum.")
		return false
		
	
	var hub_level : UpgradableHubLevel = upgradables_list[current_level]
	if HubState.currency >= hub_level.cost:
		HubState.currency -= hub_level.cost
		return true
	
	pass

