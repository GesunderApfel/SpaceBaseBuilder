class_name UpgradableLevelUI extends HBoxContainer

@onready var name_label = $NameLabel
@onready var cost_label = $CostLabel
@onready var value_label = $ValueLabel

func init_manually():
	name_label = $NameLabel
	cost_label = $CostLabel
	value_label = $ValueLabel
