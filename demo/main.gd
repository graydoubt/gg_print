class_name Main extends CanvasLayer

## Brief demo to show how [method gg.print] links back to the editor.
## 
## For this demo to work, the "gg_print" plugin must be enabled from the ProjectSettings.

@export var button1: Button:
	set(value):
		button1 = value
		button1.pressed.connect(_on_button1_pressed)

@export var button2: Button:
	set(value):
		button2 = value
		button2.pressed.connect(_on_button2_pressed)

@export var button3: Button


func _on_button1_pressed() -> void:
	gg.print("Button 1 was pressed!")


func _on_button2_pressed() -> void:
	gg.print("Button 2 was pressed!")
