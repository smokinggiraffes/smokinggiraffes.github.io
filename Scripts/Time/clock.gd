extends Label

var elapsed_time = 0.0
var timer_running = false

func _ready():
	# Initialize the label text
	text = "Time: 0.0"
	# Connect the button press signal (assuming the button is a sibling of the label)
	var start_button = get_node("../StartButton")
	start_button.connect("pressed", Callable(self, "_on_StartButton_pressed"))

func _process(delta):
	if timer_running:
		# Update the elapsed time
		elapsed_time += delta
		# Format the time to show two decimal places
		text = "Time: %.2f" % elapsed_time

func _on_StartButton_pressed():
	# Start the timer
	timer_running = true
