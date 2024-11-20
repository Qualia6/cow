extends AudioStreamPlayer2D


var stream_names: Array = []


# use by passing the array of songs to play (as StringName) and it will intelegently
#   do some modifications to only play the ones desired 
func switch(which: PackedStringArray):
	if arrays_are_identical(stream_names, which): return
	
	var playback_position: float = get_playback_position()
	
	var sync: AudioStreamSynchronized = stream.get_list_stream(0)
	
	var streams: Array = []
	stream_names = []
	for i: int in sync.stream_count:
		var considered_stream: AudioStream = sync.get_sync_stream(i)
		var stream_name: StringName = considered_stream.resource_name
		# print("found ", stream_name)
		if which.has(stream_name):
			# print("already have ", stream_name, " so adding it to streams")
			streams.append(considered_stream)
			stream_names.append(stream_name)
	
	for stream_name: StringName in which:
		if not stream_names.has(stream_name):
			# print("dont have ", stream_name, " creating it")
			var new_stream: AudioStream = create_stream(stream_name)
			streams.append(new_stream)
			stream_names.append(stream_name)
	
	for i: int in streams.size():
		# print("setting element ", i, " of sync to ", streams[i].resource_name)
		sync.set_sync_stream(i, streams[i])
	
	# print("setting stream count to ", streams.size())
	sync.stream_count = streams.size()
	
	play(playback_position)


func arrays_are_identical(a: Array, b: Array) -> bool:
	if a.size() != b.size(): return false
	for i: int in a.size():
		if a[i] != b[i]: return false
	return true


func create_stream(stream_name: String) -> AudioStream:
	var path: String = "res://music/" + stream_name + ".ogg"
	var considered_stream: AudioStreamOggVorbis = ResourceLoader.load(path) as AudioStreamOggVorbis
	considered_stream.resource_name = stream_name
	return considered_stream
