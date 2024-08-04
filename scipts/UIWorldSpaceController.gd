extends Node3D

@export var ui : Control
@export var collisionshape:CollisionShape3D


func activate():
	ui.show()
	collisionshape.disabled = false

func deactivate():
	ui.hide()
	collisionshape.disabled = true
