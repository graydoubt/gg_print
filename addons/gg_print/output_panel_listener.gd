@tool
class_name GGOutputPanelListener extends Node

## Listens to [signal RichTextLabel.meta_clicked] to open "gg.print()" links.
##
## The MetaListener expects to be attached to the EditorLog's [RichTextLabel]
##
## @experimental

var _editor_log: RichTextLabel


func _ready() -> void:
	var parent: Node = get_parent()
	if parent is RichTextLabel:
		_editor_log = parent
		_editor_log.meta_clicked.connect(_on_meta_clicked)


## Runs when a link is clicked in the RichTextLabel.
## The "link" is expected to be a [JSON] encoded [method @GDScript.get_stack] entry
func _on_meta_clicked(meta: String) -> void:
	var json := JSON.new()
	var error: int = json.parse(meta)
	if error:
		return

	var stack: Dictionary = json.data
	if not stack.has("source") or not stack.has("line"):
		return
	
	if not FileAccess.file_exists(stack["source"]):
		printerr("File %s does not exist." % [stack["source"]])
		return
	
	EditorInterface.edit_script(load(stack["source"]), stack["line"])
	EditorInterface.set_main_screen_editor("Script")
