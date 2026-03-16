extends SceneTree


func _initialize() -> void:
	var exit_code := 0

	var main := preload("res://scenes/main.tscn").instantiate()
	root.add_child(main)
	await process_frame

	var expected_player_states := ["walk", "idle", "look", "wave"]
	for state_name in expected_player_states:
		if not main.player_animation_sets.has(state_name):
			push_error("Missing player animation state: %s" % state_name)
			exit_code = 1
		if not main.player_state_scales.has(state_name):
			push_error("Missing scale metadata for state: %s" % state_name)
			exit_code = 1
		if not main.player_state_y_offsets.has(state_name):
			push_error("Missing y-offset metadata for state: %s" % state_name)
			exit_code = 1
		if not main.player_state_x_offsets.has(state_name):
			push_error("Missing x-offset metadata for state: %s" % state_name)
			exit_code = 1

	if absf(main.player_animation_sets["walk"].get_animation_speed("loop") - main.WALK_ANIMATION_FPS) > 0.01:
		push_error("Walk animation speed should match the tuned fps constant.")
		exit_code = 1
	if main.player_animation_sets["walk"].get_animation_speed("loop") >= 10.0:
		push_error("Walk animation is still too fast.")
		exit_code = 1
	if main.player_animation_sets["idle"].get_animation_speed("loop") >= main.player_animation_sets["walk"].get_animation_speed("loop"):
		push_error("Idle animation should be slower than walk.")
		exit_code = 1

	if main.player_state != "idle":
		push_error("Expected idle state on load, got %s" % main.player_state)
		exit_code = 1
	if main.world_width <= main.VIEW_WIDTH:
		push_error("World width should be wider than the viewport.")
		exit_code = 1
	if main.spot_data.size() != 3:
		push_error("Expected 3 city spots, got %d" % main.spot_data.size())
		exit_code = 1
	if main.npc_data.size() != main.NPC_DEFINITIONS.size():
		push_error("Expected %d town NPCs, got %d" % [main.NPC_DEFINITIONS.size(), main.npc_data.size()])
		exit_code = 1
	if main.npc_animation_sets.size() < 4:
		push_error("Expected multiple NPC animation sets to be loaded.")
		exit_code = 1

	var start_x: float = main.player_world_x
	main.set_move_input(1.0)
	main.simulate(0.75)
	await process_frame
	if main.player_world_x <= start_x:
		push_error("Player should move when horizontal input is applied.")
		exit_code = 1
	if main.player_state != "walk":
		push_error("Player should enter walk state while moving.")
		exit_code = 1
	if not main.player_sprite.flip_h:
		push_error("Player should face right while moving right.")
		exit_code = 1

	main.clear_move_input()
	main.simulate(0.2)
	await process_frame
	if main.player_state != "idle":
		push_error("Player should return to idle when movement stops.")
		exit_code = 1

	var after_right_x: float = main.player_world_x
	main.set_move_input(-1.0)
	main.simulate(0.55)
	await process_frame
	if main.player_world_x >= after_right_x:
		push_error("Player should move left when negative input is applied.")
		exit_code = 1
	if main.player_sprite.flip_h:
		push_error("Player should face left while moving left.")
		exit_code = 1
	main.clear_move_input()
	main.simulate(0.1)
	await process_frame

	var first_npc: Dictionary = main.npc_data[0]
	main.move_player_to(float(first_npc["x"]))
	await process_frame
	var nearest_npc: Dictionary = main.get_nearest_npc()
	if nearest_npc.is_empty():
		push_error("Expected to detect a nearby town NPC.")
		exit_code = 1
	elif String(nearest_npc["id"]) != String(first_npc["id"]):
		push_error("Nearest NPC should match the NPC at the player's position.")
		exit_code = 1

	var first_spot: Dictionary = main.spot_data[0]
	main.move_player_to(float(first_spot["x"]))
	await process_frame
	var nearest: Dictionary = main.get_nearest_spot()
	if nearest.is_empty():
		push_error("Expected to find a nearby spot after moving player to it.")
		exit_code = 1

	main.perform_interaction()
	await process_frame
	if main.get_visited_spot_count() != 1:
		push_error("Interaction should mark a spot as visited.")
		exit_code = 1
	if main.player_state != String(first_spot["action_state"]):
		push_error("Player should switch to the spot action state after interacting.")
		exit_code = 1

	main.simulate(1.4)
	await process_frame
	if main.player_state != "idle":
		push_error("Player should return to idle after the interaction pose ends.")
		exit_code = 1

	main.move_player_to(main.world_width - 40.0)
	await process_frame
	if main.player_world_x > main.world_width - 110.0:
		push_error("Player move helper should clamp to the world bounds.")
		exit_code = 1

	if exit_code == 0:
		print("Promenade smoke test passed.")

	main.queue_free()
	await process_frame
	quit(exit_code)
