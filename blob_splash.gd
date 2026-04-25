class_name BlobSplash
extends Control

var _source:Vector2
var _destination:Vector2
var _finished:Callable
var _duration = 0

func _process(delta: float) -> void:
	self.global_position = _source.lerp(_destination, _duration)
	_duration += delta / .5
	if _duration > 1:
		queue_free()
		if _finished:
			_finished.call()


func setup_splash(source:Vector2, destination:Vector2, onFinish:Callable):
	_source = source
	_destination = destination
	_finished = onFinish
	
