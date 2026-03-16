extends Control

const VIEWPORT_SIZE := Vector2(1360.0, 768.0)
const BACKDROP_SCENE := preload("res://scenes/main.tscn")
const TITLE_TEXT := "Penguin Promenade"
const EYEBROW_TEXT := "Release Notes Header"
const VERSION_TEXT := "v0.1.0"
const TAGLINE_TEXT := "CLI-first city stroll built in Godot with animated penguin WebP characters."
const DETAIL_TEXT := "First public release with the promenade loop, ambient town residents, and reproducible docs plus smoke-test tooling."
const HERO_RUN_DIR := "res://assets/player_frames/run"
const HERO_WAVE_DIR := "res://assets/tiles_frames/tile_05"
const HERO_IDLE_DIR := "res://assets/tiles_frames/tile_09"
const FEATURE_ITEMS := [
	{
		"title": "Playable Avenue",
		"body": "Walk the sunset street, follow the HUD, and visit the first three landmarks.",
		"accent": "8be9fd",
	},
	{
		"title": "Animated Town Cast",
		"body": "The release turns the remaining WebP clips into smaller looping residents across the block.",
		"accent": "fde68a",
	},
	{
		"title": "CLI-first Build",
		"body": "Smoke tests, docs, and asset measurement scripts are all ready to run from the repo.",
		"accent": "93c5fd",
	},
]

var backdrop: Node
var hero_sprite: AnimatedSprite2D
var accent_wave_sprite: AnimatedSprite2D
var accent_idle_sprite: AnimatedSprite2D


func _ready() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT)
	custom_minimum_size = VIEWPORT_SIZE
	_build_scene()
	call_deferred("_configure_backdrop")


func _build_scene() -> void:
	backdrop = BACKDROP_SCENE.instantiate()
	add_child(backdrop)

	var tint := ColorRect.new()
	tint.set_anchors_preset(Control.PRESET_FULL_RECT)
	tint.color = Color("07111bcf")
	add_child(tint)

	var glow := Panel.new()
	glow.position = Vector2(720.0, 84.0)
	glow.size = Vector2(540.0, 572.0)
	glow.add_theme_stylebox_override("panel", _style_box(Color("10233d7c"), Color("54b6ff44"), 28))
	add_child(glow)

	var hero_shadow := Panel.new()
	hero_shadow.position = Vector2(780.0, 628.0)
	hero_shadow.size = Vector2(470.0, 72.0)
	hero_shadow.add_theme_stylebox_override("panel", _style_box(Color("020617a8"), Color("00000000"), 36))
	add_child(hero_shadow)

	var hero_layer := Node2D.new()
	add_child(hero_layer)

	hero_sprite = AnimatedSprite2D.new()
	hero_sprite.centered = true
	hero_sprite.position = Vector2(1070.0, 560.0)
	hero_sprite.scale = Vector2.ONE * 1.56
	hero_sprite.flip_h = true
	hero_sprite.sprite_frames = _build_sprite_frames_from_dir(HERO_RUN_DIR, 6.4)
	hero_sprite.animation = "loop"
	hero_sprite.play()
	hero_layer.add_child(hero_sprite)

	accent_wave_sprite = AnimatedSprite2D.new()
	accent_wave_sprite.centered = true
	accent_wave_sprite.position = Vector2(858.0, 560.0)
	accent_wave_sprite.scale = Vector2.ONE * 0.98
	accent_wave_sprite.flip_h = true
	accent_wave_sprite.sprite_frames = _build_sprite_frames_from_dir(HERO_WAVE_DIR, 4.5)
	accent_wave_sprite.animation = "loop"
	accent_wave_sprite.play()
	hero_layer.add_child(accent_wave_sprite)

	accent_idle_sprite = AnimatedSprite2D.new()
	accent_idle_sprite.centered = true
	accent_idle_sprite.position = Vector2(1240.0, 586.0)
	accent_idle_sprite.scale = Vector2.ONE * 0.88
	accent_idle_sprite.flip_h = true
	accent_idle_sprite.modulate = Color("f8fafce0")
	accent_idle_sprite.sprite_frames = _build_sprite_frames_from_dir(HERO_IDLE_DIR, 4.0)
	accent_idle_sprite.animation = "loop"
	accent_idle_sprite.play()
	hero_layer.add_child(accent_idle_sprite)

	var card := PanelContainer.new()
	card.position = Vector2(56.0, 54.0)
	card.size = Vector2(610.0, 620.0)
	card.add_theme_stylebox_override("panel", _style_box(Color("07111ce6"), Color("7dd3fc4d"), 32))
	add_child(card)

	var content := MarginContainer.new()
	content.set_anchors_preset(Control.PRESET_FULL_RECT)
	content.add_theme_constant_override("margin_left", 34)
	content.add_theme_constant_override("margin_top", 30)
	content.add_theme_constant_override("margin_right", 34)
	content.add_theme_constant_override("margin_bottom", 30)
	card.add_child(content)

	var layout := VBoxContainer.new()
	layout.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	layout.size_flags_vertical = Control.SIZE_EXPAND_FILL
	layout.add_theme_constant_override("separation", 18)
	content.add_child(layout)

	var badge_row := HBoxContainer.new()
	badge_row.add_theme_constant_override("separation", 10)
	layout.add_child(badge_row)

	badge_row.add_child(_badge(EYEBROW_TEXT, Color("8be9fd"), Color("0f2f42")))
	badge_row.add_child(_badge(VERSION_TEXT, Color("fde68a"), Color("49340f")))

	var title := _make_label(TITLE_TEXT, 54, Color("fff8dc"))
	title.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	layout.add_child(title)

	var subtitle := _make_label(TAGLINE_TEXT, 24, Color("dbeafe"))
	subtitle.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	layout.add_child(subtitle)

	var detail := _make_label(DETAIL_TEXT, 18, Color("cbd5e1"))
	detail.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	layout.add_child(detail)

	var feature_column := VBoxContainer.new()
	feature_column.add_theme_constant_override("separation", 12)
	layout.add_child(feature_column)

	for feature in FEATURE_ITEMS:
		feature_column.add_child(_feature_card(String(feature["title"]), String(feature["body"]), Color(String(feature["accent"]))))

	var footer := _make_label("Rendered in Godot for the v0.1.0 release notes image.", 16, Color("93c5fd"))
	layout.add_child(footer)

	var kicker := _make_label("Sunset avenue. Small town penguins. First public drop.", 18, Color("fde68a"))
	kicker.position = Vector2(742.0, 84.0)
	add_child(kicker)


func _configure_backdrop() -> void:
	if backdrop == null:
		return

	await get_tree().process_frame

	if backdrop.has_method("move_player_to"):
		backdrop.move_player_to(float(backdrop.world_width) * 0.57)
		backdrop.player_facing = 1
		backdrop._set_player_state("walk")
		backdrop._update_player_visual()
		backdrop.spot_data.clear()
		backdrop.npc_data.clear()
		backdrop.queue_redraw()

	if backdrop.get("hud_root") != null:
		backdrop.hud_root.visible = false

	if backdrop.has_method("set_process"):
		backdrop.set_process(false)


func _make_label(text: String, font_size: int, color: Color) -> Label:
	var label := Label.new()
	label.text = text
	var settings := LabelSettings.new()
	settings.font_size = font_size
	settings.font_color = color
	label.label_settings = settings
	return label


func _badge(text: String, text_color: Color, fill_color: Color) -> PanelContainer:
	var badge := PanelContainer.new()
	badge.custom_minimum_size = Vector2(0.0, 42.0)
	badge.add_theme_stylebox_override("panel", _style_box(fill_color, text_color.darkened(0.25), 18))

	var margin := MarginContainer.new()
	margin.set_anchors_preset(Control.PRESET_FULL_RECT)
	margin.add_theme_constant_override("margin_left", 16)
	margin.add_theme_constant_override("margin_top", 8)
	margin.add_theme_constant_override("margin_right", 16)
	margin.add_theme_constant_override("margin_bottom", 8)
	badge.add_child(margin)

	var label := _make_label(text, 18, text_color)
	margin.add_child(label)
	return badge


func _feature_card(title: String, body: String, accent: Color) -> PanelContainer:
	var panel := PanelContainer.new()
	panel.custom_minimum_size = Vector2(0.0, 108.0)
	panel.add_theme_stylebox_override("panel", _style_box(Color("0d1828f0"), accent.darkened(0.25), 22))

	var margin := MarginContainer.new()
	margin.set_anchors_preset(Control.PRESET_FULL_RECT)
	margin.add_theme_constant_override("margin_left", 18)
	margin.add_theme_constant_override("margin_top", 16)
	margin.add_theme_constant_override("margin_right", 18)
	margin.add_theme_constant_override("margin_bottom", 16)
	panel.add_child(margin)

	var column := VBoxContainer.new()
	column.add_theme_constant_override("separation", 6)
	margin.add_child(column)

	column.add_child(_make_label(title, 24, accent.lightened(0.12)))

	var body_label := _make_label(body, 16, Color("d9e5f4"))
	body_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	column.add_child(body_label)

	return panel


func _style_box(fill: Color, border: Color, radius: int) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = fill
	style.border_color = border
	style.set_border_width_all(2 if border.a > 0.0 else 0)
	style.set_corner_radius_all(radius)
	return style


func _build_sprite_frames_from_dir(frame_dir: String, speed: float) -> SpriteFrames:
	var frames := SpriteFrames.new()
	frames.add_animation("loop")
	frames.set_animation_loop("loop", true)
	frames.set_animation_speed("loop", speed)

	var dir := DirAccess.open(frame_dir)
	if dir == null:
		push_error("Missing frame directory: %s" % frame_dir)
		return frames

	var file_names: PackedStringArray = []
	dir.list_dir_begin()
	var file_name := dir.get_next()
	while file_name != "":
		if not dir.current_is_dir() and file_name.get_extension().to_lower() == "png":
			file_names.append(file_name)
		file_name = dir.get_next()
	dir.list_dir_end()
	file_names.sort()

	for frame_name in file_names:
		var image := Image.new()
		if image.load("%s/%s" % [frame_dir, frame_name]) != OK:
			push_error("Failed to load frame: %s/%s" % [frame_dir, frame_name])
			continue
		frames.add_frame("loop", ImageTexture.create_from_image(image))

	return frames
