extends SceneTree


func _initialize() -> void:
	var main := preload("res://scenes/main.tscn").instantiate()
	root.add_child(main)
	await process_frame
	await process_frame

	_save_viewport_png("res://.tools/preview_title.png")

	main.set_move_input(1.0)
	for _i in range(18):
		main.simulate(1.0 / 30.0)
		await process_frame
	main.clear_move_input()
	_save_viewport_png("res://.tools/preview_walk.png")

	var second_spot: Dictionary = main.spot_data[1]
	main.move_player_to(float(second_spot["x"]))
	await process_frame
	main.perform_interaction()
	for _i in range(4):
		main.simulate(1.0 / 30.0)
		await process_frame
	_save_viewport_png("res://.tools/preview_interact.png")

	main.queue_free()
	await process_frame
	quit()


func _save_viewport_png(target_path: String) -> void:
	var image := root.get_texture().get_image()
	image.save_png(ProjectSettings.globalize_path(target_path))
