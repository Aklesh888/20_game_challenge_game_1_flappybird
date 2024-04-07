extends Area2D


@onready var points_scored = $points_scored


func _on_body_entered(body):
	if body.is_in_group('bird'):
		body.hurt()


func _on_area_2d_body_entered(body):
	if body.is_in_group('bird'):
		points_scored.play()
		get_parent().get_parent().score += 1
