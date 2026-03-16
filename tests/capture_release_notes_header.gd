extends SceneTree

const TARGET_SCENE := preload("res://scenes/release_notes_header.tscn")
const OUTPUT_PATHS := [
	"res://.tools/release-v0.1.0-header.png",
	"res://docs/public/images/releases/v0.1.0-header.png",
]


func _initialize() -> void:
	if DisplayServer.get_name().to_lower().contains("headless"):
		push_error("Release note capture needs the standard Godot renderer. Run the normal Godot executable without --headless.")
		quit(1)
		return

	var viewport := SubViewport.new()
	viewport.disable_3d = true
	viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	viewport.size = Vector2i(1360, 768)
	root.add_child(viewport)

	var scene := TARGET_SCENE.instantiate()
	viewport.add_child(scene)

	for _i in range(8):
		await process_frame

	var image := viewport.get_texture().get_image()
	for output_path in OUTPUT_PATHS:
		var absolute_path := ProjectSettings.globalize_path(output_path)
		DirAccess.make_dir_recursive_absolute(absolute_path.get_base_dir())
		image.save_png(absolute_path)

	scene.queue_free()
	await process_frame
	print("Release note header exported.")
	quit()
