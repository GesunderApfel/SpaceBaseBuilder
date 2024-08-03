class_name hub extends Node


const RAY_LENGTH = 1000.0

@onready var hub_upgrade_health_ui = $GUI_3D/Upgrade_Health/ViewportHealth/UI2D/HubUpgradeHealthUI
@onready var hub_upgrade_energy_ui = $GUI_3D/Upgrade_Energy/ViewportEnergy/UI2D/HubUpgradeEnergyUI
@onready var hub_upgrade_depot_ui = $GUI_3D/Upgrade_Depot/ViewportDepot/UI2D/HubUpgradeDepotUI


@onready var upgradable_base = $Level/Upgradable_Base
@onready var upgradable_power_station = $Level/Upgradable_PowerStation

@onready var currency = $CanvasLayer/Currency


func _ready():
	currency.text = "Currency: " + str(HubState.currency)
	pass

func _input(event):
	
	if event is InputEventKey and event.keycode == KEY_K:
		HubState.currency += 50
		currency.text = "Currency: " + str(HubState.currency)
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
			hub_upgrade_health_ui.hide()
			hub_upgrade_energy_ui.hide()
			hub_upgrade_depot_ui.hide()
			return
			
		
		if result.collider.is_in_group("hub_upgrade_health"):
			if not hub_upgrade_health_ui.upgradable_container.is_finished(HubState.hub_base_level):
				hub_upgrade_health_ui.show()
				hub_upgrade_energy_ui.hide()
				hub_upgrade_depot_ui.hide()
		elif result.collider.is_in_group("hub_upgrade_energy"):
			if not hub_upgrade_energy_ui.upgradable_container.is_finished(HubState.hub_energy_level):
				hub_upgrade_health_ui.hide()
				hub_upgrade_energy_ui.show()
				hub_upgrade_depot_ui.hide()
		elif result.collider.is_in_group("hub_upgrade_depot"):
			if not hub_upgrade_energy_ui.upgradable_container.is_finished(HubState.hub_depot_level):
				hub_upgrade_health_ui.hide()
				hub_upgrade_energy_ui.hide()
				hub_upgrade_depot_ui.show()
		elif result.collider.is_in_group("ui_health_upgrade_button"):
			if hub_upgrade_health_ui.upgradable_container.is_buyable(HubState.hub_base_level):
				hub_upgrade_health_ui.upgradable_container.upgrade_level(HubState.hub_base_level)
				currency.text = "Currency: " + str(HubState.currency)
				HubState.hub_base_level += 1
				hub_upgrade_health_ui.update_ui()
		elif result.collider.is_in_group("ui_energy_upgrade_button"):
			if hub_upgrade_energy_ui.upgradable_container.is_buyable(HubState.hub_energy_level):
				hub_upgrade_energy_ui.upgradable_container.upgrade_level(HubState.hub_energy_level)
				currency.text = "Currency: " + str(HubState.currency)
				HubState.hub_energy_level += 1
				hub_upgrade_energy_ui.update_ui()
		elif result.collider.is_in_group("ui_depot_upgrade_button"):
			if hub_upgrade_depot_ui.upgradable_container.is_buyable(HubState.hub_depot_level):
				hub_upgrade_depot_ui.upgradable_container.upgrade_level(HubState.hub_depot_level)
				currency.text = "Currency: " + str(HubState.currency)
				HubState.hub_depot_level += 1
				hub_upgrade_depot_ui.update_ui()

