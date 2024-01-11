class_name ChunkHealthBar extends Control

@export var hbox: BoxContainer;	
@export var chunk_scene: PackedScene;
var chunks: Array[DamageBar] = [];
var chunk_health_system: ChunkHealthSystem;

func initialize_chunks(system:ChunkHealthSystem)->void:
	if chunk_health_system:	
		disconnect_signals(chunk_health_system);
	for child in hbox.get_children():
		child.queue_free();
	chunks.clear();
	chunk_health_system = system;
	for i in range(chunk_health_system.chunks):
		var new_chunk = chunk_scene.instantiate();
		var bar = new_chunk as DamageBar;
		hbox.add_child(bar);	
		bar.min_value = i*chunk_health_system.chunk_health;
		bar.max_value = (i+1)*chunk_health_system.chunk_health;
		bar.set_value(chunk_health_system.get_current_health(),false);
		chunks.append(bar);
	connect_signals(chunk_health_system);

func connect_signals(health:ChunkHealthSystem)->void:
	health.health_changed.connect(health_changed)	

func disconnect_signals(health:ChunkHealthSystem)->void:
	health.health_changed.disconnect(health_changed)

func health_changed(health:int)->void:
	for chunk in chunks:	
		chunk.set_value(health);	
