class_name hub extends Node


const RAY_LENGTH = 1000.0

var upgrade_health_ui;
var upgrade_energy_ui;
var upgrade_depot_ui;

signal on_clicked_upgrade_health
signal on_clicked_upgrade_energy
signal on_clicked_upgrade_depot

@onready var upgradable_base = $Level/Upgradable_Base

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		var space_state = get_tree().root.get_world_3d().direct_space_state
		var camera3d = $Camera3D
		var from = camera3d.project_ray_origin(event.position)
		var to = from + camera3d.project_ray_normal(event.position) * RAY_LENGTH
		var query = PhysicsRayQueryParameters3D.create(from, to)
		
		query.collide_with_areas = true
		var result = space_state.intersect_ray(query)
		
		if result:
			if result.collider.is_in_group("hub_upgrade_health"):
				upgrade_health_ui.show()
				upgrade_energy_ui.hide()
				upgrade_depot_ui.hide()
			elif result.collider.is_in_group("hub_upgrade_energy"):
				upgrade_health_ui.hide()
				upgrade_energy_ui.show()
				upgrade_depot_ui.hide()
			elif result.collider.is_in_group("hub_upgrade_energy"):
				upgrade_health_ui.hide()
				upgrade_energy_ui.hide()
				upgrade_depot_ui.show()
			elif result.collider.is_in_group("ui_health_upgrade_button"):
				on_clicked_upgrade_health.emit()
			elif result.collider.is_in_group("ui_energy_upgrade_button"):
				on_clicked_upgrade_energy.emit()
			elif result.collider.is_in_group("ui_depot_upgrade_button"):
				on_clicked_upgrade_depot.emit()
