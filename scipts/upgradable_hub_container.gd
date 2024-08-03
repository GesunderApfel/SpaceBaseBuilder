class_name UpgradableHubContainer extends Resource

@export var attribute_name: String
@export var upgradables_list : Array[UpgradableHubLevel] = []

@export var attribute_icon : Texture2D
@export var attribute_icon_sucess : Texture2D
@export var attribute_icon_failure : Texture2D


func is_finished(current_level):
	if current_level>=upgradables_list.size():
		return true
	else:
		return false

func is_buyable(current_level):
	if is_finished(current_level):
		return
	
	var hub_level : UpgradableHubLevel = upgradables_list[current_level]
	if HubState.currency >= hub_level.cost:
		return true
	return false

func upgrade_level(current_level):
	var hub_level : UpgradableHubLevel = upgradables_list[current_level]
	if HubState.currency >= hub_level.cost:
		HubState.currency -= hub_level.cost
		return true
	
	return false

