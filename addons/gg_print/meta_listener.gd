@tool
extends Node

## Listens to [signal RichTextLabel.meta_clicked] to open "gg.print()" links.
##
## The MetaListener expects to be attached to the EditorLog's [RichTextLabel]
##
## @experimental

var _editor_log: RichTextLabel


func _ready():
	var parent: Node = get_parent()
	if parent is RichTextLabel:
		_editor_log = parent
		_editor_log.meta_clicked.connect(_on_meta_clicked)


## Runs when a link is clicked in the RichTextLabel.
## The "link" is expected to be a [JSON] encoded [method @GDScript.get_stack] entry
func _on_meta_clicked(meta: String):
	var json := JSON.new()
	var error: int = json.parse(meta)
	if not error:
		# The stack entry
		var stack: Dictionary = json.data
		
		# This is how you open a script for editing in the editor.
		# Could probably use some validation to ensure the [Script] resource
		# could actually be loaded.
		EditorInterface.edit_script(load(stack["source"]), stack["line"])
