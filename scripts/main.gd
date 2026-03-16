extends Node2D

const GAME_TITLE := "Penguin Promenade"
const GAME_SUBTITLE := "Side-scroll through the avenue and wander the city."
const VIEW_WIDTH := 1360.0
const VIEW_HEIGHT := 768.0
const BASE_GROUND_Y := 642.0
const PLAYER_START_X := 360.0
const PLAYER_MOVE_SPEED := 220.0
const PLAYER_BASE_SCALE := 0.48
const PLAYER_REFERENCE_CONTENT_HEIGHT := 442.0
const CAMERA_SMOOTHING := 7.5
const INTERACTION_RADIUS := 170.0
const INTERACTION_DURATION := 1.2
const WORLD_SEGMENTS := 3
const BACKGROUND_SCALE := Vector2(1.66, 1.66)
const BACKGROUND_PATH := "res://assets/backgrounds/city.png"
const FRAME_ROOT := "res://assets/tiles_frames"
const PLAYER_RUN_FRAME_ROOT := "res://assets/player_frames/run"
const WALK_ANIMATION_FPS := 7.0
const IDLE_ANIMATION_FPS := 4.0
const LOOK_ANIMATION_FPS := 4.5
const WAVE_ANIMATION_FPS := 5.5
const NPC_ANIMATION_FPS := 4.6
const NPC_INTEREST_RADIUS := 170.0
const NPC_REFERENCE_CONTENT_HEIGHT := 188.0
const PLAYER_STATE_METRICS := {
	"walk": {
		"frame_width": 560.0,
		"frame_height": 560.0,
		"content_left": 120.0,
		"content_right": 437.0,
		"content_bottom": 502.0,
		"content_height": 442.0,
	},
	"idle": {
		"frame_width": 187.0,
		"frame_height": 187.0,
		"content_left": 27.0,
		"content_right": 147.0,
		"content_bottom": 163.0,
		"content_height": 142.0,
	},
	"look": {
		"frame_width": 187.0,
		"frame_height": 187.0,
		"content_left": 46.0,
		"content_right": 147.0,
		"content_bottom": 164.0,
		"content_height": 143.0,
	},
	"wave": {
		"frame_width": 187.0,
		"frame_height": 187.0,
		"content_left": 15.0,
		"content_right": 146.0,
		"content_bottom": 165.0,
		"content_height": 142.0,
	},
}
const NPC_TILE_METRICS := {
	"tile_01": {
		"frame_width": 186.0,
		"frame_height": 186.0,
		"content_left": 43.0,
		"content_right": 161.0,
		"content_bottom": 164.0,
		"content_height": 140.0,
	},
	"tile_02": {
		"frame_width": 187.0,
		"frame_height": 186.0,
		"content_left": 28.0,
		"content_right": 156.0,
		"content_bottom": 165.0,
		"content_height": 149.0,
	},
	"tile_03": {
		"frame_width": 187.0,
		"frame_height": 186.0,
		"content_left": 31.0,
		"content_right": 143.0,
		"content_bottom": 162.0,
		"content_height": 138.0,
	},
	"tile_04": {
		"frame_width": 186.0,
		"frame_height": 187.0,
		"content_left": 27.0,
		"content_right": 160.0,
		"content_bottom": 161.0,
		"content_height": 146.0,
	},
	"tile_06": {
		"frame_width": 187.0,
		"frame_height": 187.0,
		"content_left": 20.0,
		"content_right": 162.0,
		"content_bottom": 150.0,
		"content_height": 91.0,
	},
	"tile_07": {
		"frame_width": 186.0,
		"frame_height": 187.0,
		"content_left": 31.0,
		"content_right": 166.0,
		"content_bottom": 163.0,
		"content_height": 143.0,
	},
}
const SPOT_DEFINITIONS := [
	{
		"id": "cafe",
		"label": "Sun Cafe",
		"world_ratio": 0.23,
		"color": "f59e0b",
		"action_state": "wave",
		"message": "The cafe windows glow softly. It feels like the avenue is inviting you to slow down.",
	},
	{
		"id": "crosswalk",
		"label": "Crosswalk",
		"world_ratio": 0.52,
		"color": "38bdf8",
		"action_state": "look",
		"message": "Cars hum in the distance while the crosswalk lights blink across the block.",
	},
	{
		"id": "clocktower",
		"label": "Clock Tower",
		"world_ratio": 0.82,
		"color": "a78bfa",
		"action_state": "wave",
		"message": "The tower keeps watch over the street. This stretch of the city feels calm and open.",
	},
]
const NPC_DEFINITIONS := [
	{
		"id": "courier",
		"label": "Miro Courier",
		"tile": "tile_02",
		"world_ratio": 0.12,
		"feet_offset": 0.0,
		"color": "93c5fd",
		"facing": 1,
		"scale": 1.0,
		"description": "A courier waddles past with a satchel full of tiny letters.",
	},
	{
		"id": "watcher",
		"label": "Lantern Watch",
		"tile": "tile_01",
		"world_ratio": 0.24,
		"feet_offset": -2.0,
		"color": "fca5a5",
		"facing": -1,
		"scale": 1.0,
		"description": "The lantern keeper watches the sidewalk like a calm night guard.",
	},
	{
		"id": "bench",
		"label": "Bench Friend",
		"tile": "tile_03",
		"world_ratio": 0.36,
		"feet_offset": 2.0,
		"color": "fde68a",
		"facing": 1,
		"scale": 0.94,
		"description": "A sleepy local sits low to the ground and soaks in the sunset.",
	},
	{
		"id": "tinkerer",
		"label": "Street Tinkerer",
		"tile": "tile_04",
		"world_ratio": 0.53,
		"feet_offset": 0.0,
		"color": "86efac",
		"facing": -1,
		"scale": 0.98,
		"description": "A tinkerer hunches over a gadget beside the crosswalk.",
	},
	{
		"id": "napper",
		"label": "Nap Penguin",
		"tile": "tile_06",
		"world_ratio": 0.69,
		"feet_offset": 6.0,
		"color": "c4b5fd",
		"facing": -1,
		"scale": 0.92,
		"description": "A napper has claimed the warm pavement for an afternoon break.",
	},
	{
		"id": "skater",
		"label": "Skater",
		"tile": "tile_07",
		"world_ratio": 0.86,
		"feet_offset": -3.0,
		"color": "67e8f9",
		"facing": 1,
		"scale": 1.02,
		"description": "A skater shows off a looping kick move under the clock tower.",
	},
]

var player_animation_sets: Dictionary = {}
var player_state_scales: Dictionary = {}
var player_state_y_offsets: Dictionary = {}
var player_state_x_offsets: Dictionary = {}
var npc_animation_sets: Dictionary = {}
var background_texture: Texture2D
var background_span := 0.0
var world_width := VIEW_WIDTH
var background_sprites: Array[Sprite2D] = []
var spot_data: Array[Dictionary] = []
var npc_data: Array[Dictionary] = []

var world_layer: Node2D
var npc_layer: Node2D
var player_root: Node2D
var player_sprite: AnimatedSprite2D
var hud_root: Control
var title_label: Label
var subtitle_label: Label
var visit_label: Label
var district_label: Label
var prompt_label: Label
var help_label: Label

var player_world_x := PLAYER_START_X
var player_feet_y := BASE_GROUND_Y
var player_state := ""
var player_facing := 1
var camera_x := 0.0
var interaction_timer := 0.0
var interaction_message := ""
var visited_spots: Dictionary = {}
var debug_input_enabled := false
var debug_horizontal_input := 0.0


func _ready() -> void:
	_load_assets()
	_build_scene()
	_reset_state()
	queue_redraw()


func _process(delta: float) -> void:
	_tick(delta)


func _draw() -> void:
	_draw_ground()
	_draw_npc_labels()
	_draw_spot_markers()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_E or event.keycode == KEY_SPACE or event.keycode == KEY_ENTER:
			perform_interaction()
	elif event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		perform_interaction()


func perform_interaction() -> void:
	var nearest := get_nearest_spot()
	if nearest.is_empty():
		interaction_message = "Nothing special here yet. Keep strolling down the avenue."
		interaction_timer = 0.0
		_set_player_state("idle")
		_update_hud()
		return

	visited_spots[String(nearest["id"])] = true
	interaction_timer = INTERACTION_DURATION
	interaction_message = String(nearest["message"])
	_set_player_state(String(nearest["action_state"]))
	_update_hud()


func simulate(delta: float) -> void:
	_tick(delta)


func set_move_input(value: float) -> void:
	debug_input_enabled = true
	debug_horizontal_input = clampf(value, -1.0, 1.0)


func clear_move_input() -> void:
	debug_input_enabled = false
	debug_horizontal_input = 0.0


func move_player_to(new_x: float) -> void:
	player_world_x = clampf(new_x, 110.0, world_width - 110.0)
	interaction_timer = 0.0
	_set_player_state("idle")
	_update_camera(1.0)
	_update_player_visual()
	_update_hud()
	queue_redraw()


func get_nearest_spot() -> Dictionary:
	var nearest: Dictionary = {}
	var nearest_distance := INTERACTION_RADIUS
	for spot in spot_data:
		var distance := absf(float(spot["x"]) - player_world_x)
		if distance <= nearest_distance:
			nearest_distance = distance
			nearest = spot
	return nearest


func get_visited_spot_count() -> int:
	return visited_spots.size()


func get_nearest_npc() -> Dictionary:
	var nearest: Dictionary = {}
	var nearest_distance := NPC_INTEREST_RADIUS
	for npc in npc_data:
		var distance := absf(float(npc["x"]) - player_world_x)
		if distance <= nearest_distance:
			nearest_distance = distance
			nearest = npc
	return nearest


func get_closest_spot(prefer_unvisited: bool = false) -> Dictionary:
	var nearest: Dictionary = {}
	var nearest_distance := INF
	for spot in spot_data:
		if prefer_unvisited and visited_spots.has(String(spot["id"])):
			continue
		var distance := absf(float(spot["x"]) - player_world_x)
		if distance < nearest_distance:
			nearest_distance = distance
			nearest = spot
	return nearest


func _tick(delta: float) -> void:
	var move := _get_horizontal_input()
	if absf(move) > 0.01 and interaction_timer > 0.0:
		interaction_timer = 0.0

	if interaction_timer > 0.0:
		interaction_timer = maxf(0.0, interaction_timer - delta)
	else:
		if absf(move) > 0.01:
			player_world_x = clampf(player_world_x + move * PLAYER_MOVE_SPEED * delta, 110.0, world_width - 110.0)
			player_facing = -1 if move < 0.0 else 1
			_set_player_state("walk")
		else:
			_set_player_state("idle")

	_update_camera(delta)
	_update_player_visual()
	_update_hud()
	queue_redraw()


func _load_assets() -> void:
	background_texture = _load_texture_from_image(BACKGROUND_PATH)

	player_animation_sets.clear()
	player_state_scales.clear()
	player_state_y_offsets.clear()
	player_state_x_offsets.clear()
	_register_player_state("walk", PLAYER_RUN_FRAME_ROOT, WALK_ANIMATION_FPS)
	_register_player_state("idle", "%s/tile_09" % FRAME_ROOT, IDLE_ANIMATION_FPS)
	_register_player_state("look", "%s/tile_08" % FRAME_ROOT, LOOK_ANIMATION_FPS)
	_register_player_state("wave", "%s/tile_05" % FRAME_ROOT, WAVE_ANIMATION_FPS)

	npc_animation_sets.clear()
	for npc_definition in NPC_DEFINITIONS:
		var tile_name := String(npc_definition["tile"])
		if not npc_animation_sets.has(tile_name):
			npc_animation_sets[tile_name] = _build_sprite_frames_from_dir("%s/%s" % [FRAME_ROOT, tile_name], NPC_ANIMATION_FPS)


func _build_scene() -> void:
	for child in get_children():
		child.queue_free()

	world_layer = Node2D.new()
	add_child(world_layer)

	_build_background()
	npc_layer = Node2D.new()
	world_layer.add_child(npc_layer)
	_build_npcs()
	_build_spots()

	player_root = Node2D.new()
	world_layer.add_child(player_root)

	player_sprite = AnimatedSprite2D.new()
	player_sprite.centered = true
	player_root.add_child(player_sprite)

	var hud_layer := CanvasLayer.new()
	add_child(hud_layer)

	hud_root = Control.new()
	hud_root.set_anchors_preset(Control.PRESET_FULL_RECT)
	hud_layer.add_child(hud_root)

	var panel := PanelContainer.new()
	panel.position = Vector2(28.0, 24.0)
	panel.size = Vector2(520.0, 188.0)
	panel.add_theme_stylebox_override("panel", _panel_style(Color("0f1728d8"), Color("8be9fd")))
	hud_root.add_child(panel)

	var panel_box := VBoxContainer.new()
	panel_box.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	panel_box.size_flags_vertical = Control.SIZE_EXPAND_FILL
	panel_box.add_theme_constant_override("separation", 6)
	panel.add_child(panel_box)

	title_label = _make_label(GAME_TITLE, 34, Color("fff8dc"))
	subtitle_label = _make_label(GAME_SUBTITLE, 16, Color("d7ecff"))
	visit_label = _make_label("", 22, Color("fde68a"))
	district_label = _make_label("", 20, Color("86efac"))
	for label in [title_label, subtitle_label, visit_label, district_label]:
		panel_box.add_child(label)

	prompt_label = _make_label("", 28, Color("ffffff"))
	prompt_label.position = Vector2(28.0, 248.0)
	prompt_label.custom_minimum_size = Vector2(860.0, 36.0)
	hud_root.add_child(prompt_label)

	help_label = _make_label("Arrow / A D to stroll   |   E / Space to check out a spot", 20, Color("f8fafc"))
	help_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	help_label.position = Vector2(VIEW_WIDTH - 760.0, 32.0)
	help_label.custom_minimum_size = Vector2(720.0, 36.0)
	hud_root.add_child(help_label)

	var footer := _make_label("Background: city skyline  |  Stroll the repeated avenue and visit glowing landmarks", 16, Color("a5b4fc"))
	footer.position = Vector2(28.0, VIEW_HEIGHT - 38.0)
	footer.custom_minimum_size = Vector2(960.0, 24.0)
	hud_root.add_child(footer)

	_update_player_visual()


func _build_background() -> void:
	background_sprites.clear()
	background_span = background_texture.get_width() * BACKGROUND_SCALE.x
	world_width = background_span * WORLD_SEGMENTS

	for index in range(WORLD_SEGMENTS):
		var sprite := Sprite2D.new()
		sprite.texture = background_texture
		sprite.centered = false
		sprite.scale = BACKGROUND_SCALE
		sprite.position = Vector2(background_span * index, 0.0)
		world_layer.add_child(sprite)
		background_sprites.append(sprite)


func _build_spots() -> void:
	spot_data.clear()
	for definition in SPOT_DEFINITIONS:
		var spot: Dictionary = definition.duplicate(true)
		spot["x"] = world_width * float(definition["world_ratio"])
		spot_data.append(spot)


func _reset_state() -> void:
	player_world_x = PLAYER_START_X
	player_feet_y = BASE_GROUND_Y
	player_state = ""
	player_facing = 1
	camera_x = 0.0
	interaction_timer = 0.0
	interaction_message = "Stroll the avenue and head toward the next landmark."
	visited_spots.clear()
	_set_player_state("idle")
	_update_camera(1.0)
	_update_player_visual()
	_update_hud()


func _draw_ground() -> void:
	draw_rect(Rect2(0.0, BASE_GROUND_Y - 10.0, VIEW_WIDTH, VIEW_HEIGHT - BASE_GROUND_Y + 10.0), Color("202637"), true)
	draw_rect(Rect2(0.0, BASE_GROUND_Y - 4.0, VIEW_WIDTH, 7.0), Color("f1c36d"), true)
	draw_rect(Rect2(0.0, BASE_GROUND_Y + 44.0, VIEW_WIDTH, 82.0), Color("2b3046"), true)
	draw_rect(Rect2(0.0, BASE_GROUND_Y + 126.0, VIEW_WIDTH, VIEW_HEIGHT - (BASE_GROUND_Y + 126.0)), Color("141827"), true)

	var dash_width := 120.0
	var gap := 74.0
	var total := dash_width + gap
	var start_x := -fposmod(camera_x, total)
	var dash_y := BASE_GROUND_Y + 76.0
	for index in range(14):
		draw_rect(Rect2(start_x + total * index, dash_y, dash_width, 10.0), Color("fff1a8"), true)


func _draw_npc_labels() -> void:
	var fallback_font: Font = ThemeDB.fallback_font
	if fallback_font == null:
		return

	var nearest_npc := get_nearest_npc()
	for npc in npc_data:
		var screen_x := float(npc["x"]) - camera_x
		if screen_x < -160.0 or screen_x > VIEW_WIDTH + 160.0:
			continue

		var feet_y := float(npc["feet_y"])
		var color := Color(String(npc["color"]))
		var is_near := not nearest_npc.is_empty() and String(nearest_npc["id"]) == String(npc["id"])
		var label_y := feet_y - float(npc["label_height"]) - 32.0

		if is_near:
			draw_arc(Vector2(screen_x, feet_y + 10.0), 26.0, 0.0, TAU, 28, color.lightened(0.3), 3.0)

		draw_string(
			fallback_font,
			Vector2(screen_x - 96.0, label_y),
			String(npc["label"]),
			HORIZONTAL_ALIGNMENT_LEFT,
			192.0,
			18,
			color.lightened(0.25 if is_near else 0.05)
		)


func _draw_spot_markers() -> void:
	var fallback_font: Font = ThemeDB.fallback_font
	if fallback_font == null:
		return

	for spot in spot_data:
		var screen_x := float(spot["x"]) - camera_x
		if screen_x < -160.0 or screen_x > VIEW_WIDTH + 160.0:
			continue

		var color := Color(String(spot["color"]))
		var visited := visited_spots.has(String(spot["id"]))
		var near := not get_nearest_spot().is_empty() and String(get_nearest_spot()["id"]) == String(spot["id"])
		var post_top := BASE_GROUND_Y - 96.0
		var lamp_y := BASE_GROUND_Y - 106.0

		draw_line(Vector2(screen_x, post_top), Vector2(screen_x, BASE_GROUND_Y), color.darkened(0.2), 4.0)
		draw_circle(Vector2(screen_x, lamp_y), 12.0 if near else 10.0, color)
		draw_circle(Vector2(screen_x, BASE_GROUND_Y + 8.0), 20.0, color.darkened(0.45))
		if visited:
			draw_arc(Vector2(screen_x, lamp_y), 18.0, 0.0, TAU, 24, color.lightened(0.35), 3.0)

		draw_string(
			fallback_font,
			Vector2(screen_x - 78.0, post_top - 12.0),
			String(spot["label"]),
			HORIZONTAL_ALIGNMENT_LEFT,
			160.0,
			18,
			color.lightened(0.3)
		)


func _build_npcs() -> void:
	npc_data.clear()
	for definition in NPC_DEFINITIONS:
		var npc_root := Node2D.new()
		npc_layer.add_child(npc_root)

		var sprite := AnimatedSprite2D.new()
		sprite.centered = true
		npc_root.add_child(sprite)

		var tile_name := String(definition["tile"])
		sprite.sprite_frames = npc_animation_sets[tile_name]
		sprite.animation = "loop"
		sprite.play()

		var metrics: Dictionary = NPC_TILE_METRICS.get(tile_name, {})
		var scale_value := float(definition["scale"])
		var y_offset := NPC_REFERENCE_CONTENT_HEIGHT
		var x_offset := 0.0
		if not metrics.is_empty():
			scale_value *= NPC_REFERENCE_CONTENT_HEIGHT / float(metrics["content_height"])
			var frame_center_x := float(metrics["frame_width"]) * 0.5
			var frame_center_y := float(metrics["frame_height"]) * 0.5
			var content_center_x := (float(metrics["content_left"]) + float(metrics["content_right"])) * 0.5
			x_offset = (content_center_x - frame_center_x) * scale_value
			y_offset = (float(metrics["content_bottom"]) - frame_center_y) * scale_value

		var should_flip := int(definition["facing"]) > 0
		sprite.flip_h = should_flip
		sprite.scale = Vector2.ONE * scale_value
		sprite.position = Vector2(x_offset if should_flip else -x_offset, -y_offset)

		var npc_x := world_width * float(definition["world_ratio"])
		var npc_feet_y := BASE_GROUND_Y + float(definition["feet_offset"])
		npc_root.position = Vector2(npc_x, npc_feet_y)

		var npc: Dictionary = definition.duplicate(true)
		npc["root"] = npc_root
		npc["sprite"] = sprite
		npc["x"] = npc_x
		npc["feet_y"] = npc_feet_y
		npc["label_height"] = y_offset
		npc_data.append(npc)


func _get_horizontal_input() -> float:
	if debug_input_enabled:
		return debug_horizontal_input

	var move := 0.0
	if Input.is_action_pressed("ui_left") or Input.is_key_pressed(KEY_A):
		move -= 1.0
	if Input.is_action_pressed("ui_right") or Input.is_key_pressed(KEY_D):
		move += 1.0
	return clampf(move, -1.0, 1.0)


func _update_camera(delta: float) -> void:
	var max_camera := maxf(0.0, world_width - VIEW_WIDTH)
	var target_camera := clampf(player_world_x - VIEW_WIDTH * 0.5, 0.0, max_camera)
	var weight := 1.0 if delta >= 1.0 else clampf(delta * CAMERA_SMOOTHING, 0.0, 1.0)
	camera_x = lerpf(camera_x, target_camera, weight)
	world_layer.position.x = -camera_x


func _update_player_visual() -> void:
	var y_offset := float(player_state_y_offsets.get(player_state, PLAYER_BASE_SCALE * PLAYER_REFERENCE_CONTENT_HEIGHT))
	var x_offset := float(player_state_x_offsets.get(player_state, 0.0))
	var should_flip := player_facing > 0
	player_root.position = Vector2(player_world_x, player_feet_y)
	player_sprite.flip_h = should_flip
	player_sprite.position = Vector2(x_offset if should_flip else -x_offset, -y_offset)


func _update_hud() -> void:
	visit_label.text = "Visited  %d / %d" % [visited_spots.size(), spot_data.size()]
	district_label.text = "District  %s" % _get_district_name()
	subtitle_label.text = _get_guide_text()

	var nearest := get_nearest_spot()
	var nearest_npc := get_nearest_npc()
	if interaction_timer > 0.0:
		prompt_label.text = interaction_message
	elif not nearest.is_empty():
		prompt_label.text = "Press E or Space to check out %s." % String(nearest["label"])
	elif not nearest_npc.is_empty():
		prompt_label.text = String(nearest_npc["description"])
	else:
		prompt_label.text = interaction_message


func _get_guide_text() -> String:
	var closest := get_closest_spot(true)
	if closest.is_empty():
		return "All landmarks visited. Keep wandering through the avenue."

	var distance := float(closest["x"]) - player_world_x
	if absf(distance) <= INTERACTION_RADIUS:
		return "You are near %s." % String(closest["label"])
	if distance > 0.0:
		return "Next landmark: %s to the right." % String(closest["label"])
	return "Next landmark: %s to the left." % String(closest["label"])


func _get_district_name() -> String:
	var ratio := 0.0 if world_width <= 0.0 else player_world_x / world_width
	if ratio < 0.34:
		return "West Market"
	if ratio < 0.67:
		return "Midtown Avenue"
	return "East Clockside"


func _register_player_state(state_name: String, frame_dir: String, speed: float, loop: bool = true) -> void:
	var frames := _build_sprite_frames_from_dir(frame_dir, speed, loop)
	player_animation_sets[state_name] = frames

	var metrics: Dictionary = PLAYER_STATE_METRICS.get(state_name, {})
	var scale_value := PLAYER_BASE_SCALE
	var y_offset := PLAYER_BASE_SCALE * PLAYER_REFERENCE_CONTENT_HEIGHT
	var x_offset := 0.0
	if not metrics.is_empty():
		scale_value = PLAYER_BASE_SCALE * PLAYER_REFERENCE_CONTENT_HEIGHT / float(metrics["content_height"])
		var frame_center_x := float(metrics["frame_width"]) * 0.5
		var frame_center_y := float(metrics["frame_height"]) * 0.5
		var content_center_x := (float(metrics["content_left"]) + float(metrics["content_right"])) * 0.5
		x_offset = (content_center_x - frame_center_x) * scale_value
		y_offset = (float(metrics["content_bottom"]) - frame_center_y) * scale_value

	player_state_scales[state_name] = scale_value
	player_state_y_offsets[state_name] = y_offset
	player_state_x_offsets[state_name] = x_offset


func _build_sprite_frames_from_dir(frame_dir: String, speed: float = 12.0, loop: bool = true) -> SpriteFrames:
	var frames := SpriteFrames.new()
	frames.add_animation("loop")
	frames.set_animation_loop("loop", loop)
	frames.set_animation_speed("loop", speed)

	var file_names: PackedStringArray = []
	var dir := DirAccess.open(frame_dir)
	if dir == null:
		push_error("Missing animation directory: %s" % frame_dir)
		return frames

	dir.list_dir_begin()
	var file_name := dir.get_next()
	while file_name != "":
		if not dir.current_is_dir() and file_name.get_extension().to_lower() == "png":
			file_names.append(file_name)
		file_name = dir.get_next()
	dir.list_dir_end()
	file_names.sort()

	for frame_name in file_names:
		var frame_texture := _load_texture_from_image("%s/%s" % [frame_dir, frame_name])
		frames.add_frame("loop", frame_texture)

	return frames


func _load_texture_from_image(path: String) -> Texture2D:
	var image := Image.new()
	var load_error := image.load(path)
	if load_error != OK:
		push_error("Failed to load image: %s" % path)
		return ImageTexture.create_from_image(Image.create(8, 8, false, Image.FORMAT_RGBA8))
	return ImageTexture.create_from_image(image)


func _set_player_state(next_state: String) -> void:
	if player_state == next_state:
		return
	if not player_animation_sets.has(next_state):
		push_error("Missing player animation state: %s" % next_state)
		return

	player_state = next_state
	player_sprite.sprite_frames = player_animation_sets[next_state]
	player_sprite.scale = Vector2.ONE * float(player_state_scales.get(next_state, PLAYER_BASE_SCALE))
	player_sprite.animation = "loop"
	player_sprite.play()


func _make_label(text: String, font_size: int, color: Color) -> Label:
	var label := Label.new()
	label.text = text
	var settings := LabelSettings.new()
	settings.font_size = font_size
	settings.font_color = color
	label.label_settings = settings
	return label


func _panel_style(fill: Color, border: Color) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = fill
	style.border_color = border
	style.set_border_width_all(2)
	style.set_corner_radius_all(18)
	style.content_margin_left = 18
	style.content_margin_top = 16
	style.content_margin_right = 18
	style.content_margin_bottom = 16
	return style
