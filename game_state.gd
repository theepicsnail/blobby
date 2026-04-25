extends Node



var current_seed=0
func set_seed(i:int):
	current_seed = i
	seed(i)
	
func reset_rng():
	set_seed(current_seed)
	
var board_size = 4

enum GameSpeedEnum { NORMAL=0, FAST=1, INSTANT=2 }
var gameSpeed:GameSpeedEnum = GameSpeedEnum.NORMAL


var _blob_to_pos = {}
var _pos_to_blob = {}

func get_pos(blob:Blob)->Vector2i:
	return _blob_to_pos.get(blob, null)
func get_blob(pos:Vector2i)->Blob:
	return _pos_to_blob.get(pos, null)
	
func grid_clear():
	_blob_to_pos = {}
	_pos_to_blob = {}
	
func grid_set(blob:Blob, pos:Vector2i):
	_blob_to_pos[blob]=pos
	_pos_to_blob[pos]=blob
