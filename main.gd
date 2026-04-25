extends Node2D
var shown_win = false
var clicks:int = 0:
	set(v):
		clicks = v
		%MoveCount.text =  "%s" % clicks
		
func game_started():
	shown_win = false
	clicks = 0
func _ready() -> void:
	EventQueue.generate_board.connect(game_started)
	EventQueue.on_blob_clicked.connect(func(b):clicks+=1)
	EventQueue.spawn_particle.connect(%Grid.spawn_particle)
	EventQueue.on_blob_explode.connect(blob_popped)
	EventQueue.board_stable.connect(check_win)
	%SeedSelector.value = randi()
	%SizeSelector.value = GameState.board_size

func _on_seed_selector_value_changed(value: float) -> void:
	GameState.set_seed(value)
	EventQueue.generate_board.emit()

func _on_speed_selector_item_selected(index: int) -> void:
	GameState.gameSpeed = index
		


func _on_size_selector_value_changed(value: float) -> void:
	GameState.board_size = value
	EventQueue.generate_board.emit()

func blob_popped(blob:Blob):
	if %SoundEnabled.button_pressed:
		$AudioStreamPlayer2D.play()


func _on_max_all_pressed() -> void:
	var size = GameState.board_size
	for x in range(size):
		for y in range(size):
			var blob = GameState.get_blob(Vector2i(x,y))
			var d = 3 - blob.blob_size
			blob.blob_size += d
			clicks += d
			


func _win_button_pressed() -> void:
	%YouWin.visible = false

func check_win()->void:
	print("Check win")
	if shown_win:
		return
	if %Grid.particles >0:
		print("Still particles")
		return
	var size = GameState.board_size
	for x in range(size):
		for y in range(size):
			var blob = GameState.get_blob(Vector2i(x,y))
			if blob.blob_size ==3:
				print("Found 3")
				return
	%YouWin.visible = true
	shown_win = true
