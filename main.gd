extends Node2D

var clicks:int = 0:
	set(v):
		clicks = v
		%MoveCount.text =  "%s" % clicks
		
func _ready() -> void:
	EventQueue.generate_board.connect(func():clicks =0)
	EventQueue.on_blob_clicked.connect(func(b):clicks+=1)
	EventQueue.spawn_particle.connect(%Grid.spawn_particle)
	EventQueue.on_blob_explode.connect(blob_popped)
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
			
