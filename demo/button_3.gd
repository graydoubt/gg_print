extends Button

## Button 3


func _ready():
	pressed.connect(_on_button3_pressed)


func _on_button3_pressed():
	gg.print("I'm hiding here!")
