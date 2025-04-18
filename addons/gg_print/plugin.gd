@tool
extends EditorPlugin

## gg.print() plugin
## @experimental
##
## Once loaded, "gg.print()" can be used to log clickable output that will take you to the source code in the editor.
##
## @tutorial(EditorLog setup in the engine source): https://github.com/godotengine/godot/blob/4.2.2-stable/editor/editor_log.cpp#L384


## The "namespace" that "print" will be available under
const AUTOLOAD_NAME = "gg"

const AUTOLOAD_SCENE = "res://addons/gg_print/gg_print.tscn"

## This listener will get attached to the Editor's log output
const OUTPUT_PANEL_LISTENER = "res://addons/gg_print/output_panel_listener.tscn"

var _output_panel: RichTextLabel

var output_panel_listener: GGOutputPanelListener


func _enter_tree():
	_output_panel = _find_output_panel()
	if _output_panel:
		#print("Found output panel at %s" % [_output_panel.get_path()])
		output_panel_listener = load(OUTPUT_PANEL_LISTENER).instantiate()
		_output_panel.add_child(output_panel_listener)


func _exit_tree():
	if _output_panel.get_children().has(output_panel_listener):
		_output_panel.remove_child(output_panel_listener)
		output_panel_listener.free()


func _enable_plugin():
	add_autoload_singleton(AUTOLOAD_NAME, AUTOLOAD_SCENE)
	print("gg.print() editor integration enabled")


func _disable_plugin():
	remove_autoload_singleton(AUTOLOAD_NAME)
	print("gg.print() editor integration disabled")


func _find_output_panel() -> Node:
	var editor_log: Node = _find_editor_log(get_tree().root)
	if editor_log:
		var rtl = editor_log.find_child("*RichTextLabel*", true, false)
		return rtl
	return null


# Trawling for the EditorLog
func _find_editor_log(node: Node) -> Node:
	if node.name.contains("EditorLog"):
		return node
	for child in node.get_children():
		var found: Node = _find_editor_log(child)
		if found:
			return found
	return null
