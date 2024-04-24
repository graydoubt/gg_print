extends CanvasLayer

## Brief demo showing links back to the editor.
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


func _on_button1_pressed():
	gg.print("Button 1 was pressed!")

func _on_button2_pressed():
	gg.print("Button 2 was pressed!")
