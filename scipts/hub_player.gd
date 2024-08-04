class_name hub extends Node


const RAY_LENGTH = 1000.0


@onready var upgrade_health = $GUI_3D/Upgrade_Health
@onready var upgrade_energy = $GUI_3D/Upgrade_Energy
@onready var upgrade_docks = $GUI_3D/Upgrade_Docks
@onready var upgrade_research = $GUI_3D/Upgrade_Research

@onready var hub_upgrade_health_ui = $GUI_3D/Upgrade_Health/ViewportHealth/UI2D/HubUpgradeHealthUI
@onready var hub_upgrade_energy_ui = $GUI_3D/Upgrade_Energy/ViewportEnergy/UI2D/HubUpgradeEnergyUI
@onready var hub_upgrade_research_ui = $GUI_3D/Upgrade_Research/ViewportResearch/UI2D/HubUpgradeResearchUI
@onready var hub_upgrade_docks_ui = $GUI_3D/Upgrade_Docks/ViewportDocks/UI2D/HubUpgradeDocksUI


@onready var upgradable_base = $Level/Upgradable_Base
@onready var upgradable_power_station = $Level/Upgradable_PowerStation
@onready var upgradable_research_center = $Level/Upgradable_Research_Center
@onready var upgradable_ship_docks = $Level/Upgradable_Ship_Docks

@onready var currency = $CanvasLayer/Currency


func _ready():
	currency.text = "Currency: " + str(HubState.currency) + "$"
	pass

func _input(event):
	
	if event is InputEventKey and event.keycode == KEY_K:
		HubState.currency += 50
		currency.text = "Currency: " + str(HubState.currency)+ "$"
		return
	
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		var space_state = get_tree().root.get_world_3d().direct_space_state
		var camera3d = $Camera3D
		var from = camera3d.project_ray_origin(event.position)
		var to = from + camera3d.project_ray_normal(event.position) * RAY_LENGTH
		var query = PhysicsRayQueryParameters3D.create(from, to)
		
		query.collide_with_areas = true
		var result = space_state.intersect_ray(query)
		
		if not result:
			upgrade_health.deactivate()
			upgrade_energy.deactivate()
			upgrade_docks.deactivate()
			upgrade_research.deactivate()
			return
		
		if result.collider.is_in_group("hub_upgrade_health"):
			if not hub_upgrade_health_ui.upgradable_container.is_finished(HubState.hub_base_level):
				upgrade_health.activate()
				upgrade_energy.deactivate()
				upgrade_docks.deactivate()
				upgrade_research.deactivate()
		elif result.collider.is_in_group("hub_upgrade_energy"):
			if not hub_upgrade_energy_ui.upgradable_container.is_finished(HubState.hub_energy_level):
				upgrade_health.deactivate()
				upgrade_energy.activate()
				upgrade_docks.deactivate()
				upgrade_research.deactivate()
		elif result.collider.is_in_group("hub_upgrade_docks"):
			if not hub_upgrade_docks_ui.upgradable_container.is_finished(HubState.hub_docks_level):
				upgrade_health.deactivate()
				upgrade_energy.deactivate()
				upgrade_docks.activate()
				upgrade_research.deactivate()
		elif result.collider.is_in_group("hub_upgrade_research"):
			if not hub_upgrade_research_ui.upgradable_container.is_finished(HubState.hub_research_level):
				upgrade_health.deactivate()
				upgrade_energy.deactivate()
				upgrade_docks.deactivate()
				upgrade_research.activate()
		elif result.collider.is_in_group("ui_health_upgrade_button"):
			if hub_upgrade_health_ui.upgradable_container.is_buyable(HubState.hub_base_level):
				hub_upgrade_health_ui.upgradable_container.upgrade_level(HubState.hub_base_level)
				currency.text = "Currency: " + str(HubState.currency)
				HubState.hub_base_level += 1
				hub_upgrade_health_ui.update_ui()
				upgradable_base.upgrade()
		elif result.collider.is_in_group("ui_energy_upgrade_button"):
			if hub_upgrade_energy_ui.upgradable_container.is_buyable(HubState.hub_energy_level):
				hub_upgrade_energy_ui.upgradable_container.upgrade_level(HubState.hub_energy_level)
				currency.text = "Currency: " + str(HubState.currency)
				HubState.hub_energy_level += 1
				hub_upgrade_energy_ui.update_ui()
				upgradable_power_station.upgrade()
		elif result.collider.is_in_group("ui_docks_upgrade_button"):
			if hub_upgrade_docks_ui.upgradable_container.is_buyable(HubState.hub_docks_level):
				hub_upgrade_docks_ui.upgradable_container.upgrade_level(HubState.hub_docks_level)
				currency.text = "Currency: " + str(HubState.currency)
				HubState.hub_docks_level += 1
				hub_upgrade_docks_ui.update_ui()
				upgradable_ship_docks.upgrade()
		elif result.collider.is_in_group("ui_research_upgrade_button"):
			if hub_upgrade_research_ui.upgradable_container.is_buyable(HubState.hub_research_level):
				hub_upgrade_research_ui.upgradable_container.upgrade_level(HubState.hub_research_level)
				currency.text = "Currency: " + str(HubState.currency)
				HubState.hub_research_level += 1
				hub_upgrade_research_ui.update_ui()
				upgradable_research_center.upgrade()
