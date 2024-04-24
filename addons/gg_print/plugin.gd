@tool
extends EditorPlugin

## gg.print() plugin
##
## Once loaded, "gg.print()" can be used to log clickable output that will take you to the source code in the editor.
##
## @experimental
## @tutorial(EditorLog setup in the engine source): https://github.com/godotengine/godot/blob/4.2.2-stable/editor/editor_log.cpp#L384


## The "namespace" that "print" will be available under
const AUTOLOAD_NAME = "gg"

## This listener will get attached to the Editor's log output
const META_LISTENER = "res://addons/gg_print/meta_listener.tscn"

var _output_panel: RichTextLabel

var meta_listener: Node


func _enter_tree():
	add_autoload_singleton(AUTOLOAD_NAME, "res://addons/gg_print/gg.tscn")
	_output_panel = _find_output_panel()
	if _output_panel:
		print("Found output panel at %s" % [_output_panel.get_path()])
		meta_listener = load(META_LISTENER).instantiate()
		_output_panel.add_child(meta_listener)


func _exit_tree():
	remove_autoload_singleton(AUTOLOAD_NAME)
	if _output_panel.get_children().has(meta_listener):
		_output_panel.remove_child(meta_listener)
		meta_listener.free()


func _find_output_panel() -> Node:
	var editor_log: Node = _find_editor_log(get_tree().root)
	if editor_log:
		var rtl = editor_log.find_child("*RichTextLabel*", true, false)
		return rtl
	return null


## Trawling for the EditorLog
func _find_editor_log(node: Node) -> Node:
	if node.name.contains("EditorLog"):
		return node
	for child in node.get_children():
		var found: Node = _find_editor_log(child)
		if found:
			return found
	return null

