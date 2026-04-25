class_name Blob
extends Control

var _dirty = false

var blob_size: int = 2:
	set(v):
		blob_size = v
		%Blob.frame = randi()%4
		_dirty = true

func _on_button_pressed() -> void:
	EventQueue.on_blob_clicked.emit(self)

func grow_blob():
	if blob_size == 3:
		blob_size = 0
		EventQueue.on_blob_explode.emit(self)
	else:
		blob_size += 1


func get_splash_pos()->Vector2:
	return %Blob.global_position

func _on_button_mouse_entered() -> void:
	_dirty = true

func _on_button_mouse_exited() -> void:
	_dirty = true

func _process(delta: float) -> void:
	if not _dirty:
		return
	_dirty = false
	
	if not %Button.is_hovered():
		%Cursor.play("default")
	elif blob_size == 3:
		%Cursor.play("Explode")
	else:
		%Cursor.play("Add")
	%Blob.play("Level%s" % blob_size)
	
