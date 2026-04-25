extends Node
signal on_blob_clicked(blob:Blob)
signal on_blob_explode(blob:Blob)
signal generate_board()
signal spawn_particle(source:Blob, destination:Blob)
signal board_stable()

var queue:Array[Callable] = []

func _ready():
	on_blob_clicked.connect(print.bind("on_blob_clicked"))
	on_blob_explode.connect(print.bind("on_blob_explode"))

	on_blob_clicked.connect(func(b:Blob):queue.push_back(b.grow_blob))
	on_blob_explode.connect(explodeBlob)

func explodeBlob(blob:Blob):
	var pos = GameState.get_pos(blob)
	for delta in [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT]:
		var nblob = GameState.get_blob(delta + pos)
		if nblob == null:
			continue
		
		if GameState.gameSpeed == GameState.GameSpeedEnum.NORMAL:
			spawn_particle.emit(blob, nblob)
		else:
			queue.push_back(nblob.grow_blob)

func _process(delta: float) -> void:
	var todo = queue.size()
	if not todo:
		return
		
	if GameState.gameSpeed == GameState.GameSpeedEnum.INSTANT:
		while queue.size() > 0:
			queue.pop_front().call()
	else:
		queue.pop_front().call()
		
	if queue.size() == 0:
		board_stable.emit()
		
	
	
