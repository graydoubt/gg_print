@tool
extends EditorPlugin

## gg.print() plugin
##
## Once loaded, "gg.print()" can be used to log clickable output that will take
## you to the source code in the editor.
##
## @tutorial(EditorLog setup in the engine source): https://github.com/godotengine/godot/blob/4.2.2-stable/editor/editor_log.cpp#L384


## The "namespace" that "print" is available under
const AUTOLOAD_NAME = "gg"

const AUTOLOAD_SCENE = "res://addons/gg_print/print.tscn"

## This listener is attached to the Editor's log output
const OUTPUT_PANEL_LISTENER = "res://addons/gg_print/output_panel_listener.tscn"

var _output_panel: RichTextLabel

var _output_panel_listener: GGOutputPanelListener


func _enter_tree() -> void:
	_output_panel = _find_output_panel()
	if _output_panel:
		_output_panel_listener = load(OUTPUT_PANEL_LISTENER).instantiate()
		_output_panel.add_child(_output_panel_listener)


func _exit_tree() -> void:
	if _output_panel and _output_panel.get_children().has(_output_panel_listener):
		_output_panel.remove_child(_output_panel_listener)
		_output_panel_listener.queue_free()


func _enable_plugin() -> void:
	add_autoload_singleton(AUTOLOAD_NAME, AUTOLOAD_SCENE)
	print("%s.print() editor integration enabled" % [AUTOLOAD_NAME])


func _disable_plugin() -> void:
	remove_autoload_singleton(AUTOLOAD_NAME)
	print("%s.print() editor integration disabled" % [AUTOLOAD_NAME])


func _find_output_panel() -> Node:
	var base_control: Node = EditorInterface.get_base_control()
	var nodes: Array[Node] = base_control.find_children("*", "EditorLog", true, false)
	if not nodes.size():
		return null

	var editor_log: Node = nodes.front()
	return editor_log.find_child("*RichTextLabel*", true, false)
