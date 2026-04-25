extends Control


func generate_board():
	for child in %GridContainer.get_children():
		child.queue_free()
	
	GameState.grid_clear()
	GameState.reset_rng()
	var board_size = GameState.board_size
	%GridContainer.columns = board_size
	for y in range(board_size):
		for x in range(board_size):
			var pos = Vector2i(x,y)
			var blob = preload("uid://c151m8b8oqoej").instantiate()
			blob.blob_size = randi()%4
			%GridContainer.add_child(blob)
			GameState.grid_set(blob, pos)
			
	# Blob size = 100
	# Cell separation size = 16
	var natural_size = board_size * 100 + (board_size-1) * 16 
	%GridContainer.scale = Vector2.ONE * 500.0 / natural_size
	


func spawn_particle(source:Blob, destination:Blob):
	const BLOB_SPLASH = preload("uid://cwt83ktbu4bq2")
	var particle:BlobSplash = BLOB_SPLASH.instantiate()
	particle.setup_splash(
		source.get_splash_pos(),
		destination.get_splash_pos(),
		destination.grow_blob
	)
	%GridContainer.add_child(particle)


func _ready() -> void:
	EventQueue.generate_board.connect(generate_board)
	GameState.board_size = 4
	generate_board()
