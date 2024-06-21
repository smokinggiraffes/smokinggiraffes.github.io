extends Control
#class_name slot_machine_ui

var betSize : int = 0

@onready var betLabel = $betAmount
@onready var resultLabel = $result
@onready var spinAnimation = $spriteContainer/Sprite2D/AnimationPlayer
@onready var spinSound = $spinSound

var animation_time = 1.0  # Adjust this for desired animation duration
var fade_out_delay = 0.5  # Adjust this to delay the fade-out

var reelResult1
var reelResult2
var reelResult3

var receivedHowManyTimes = 0

var betValue
var betResult
var winningMultiplier = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	#visible = false
	betLabel.text = "$" + str(betSize)
	updatePlayerCash()
	SignalBank.rollFinished.connect(Callable(self,"_receiveNumber"))
	
	
func _receiveNumber(reelID,rngResult):
	receivedHowManyTimes +=1
	match reelID:
		1:
			reelResult1 = rngResult
		2:
			reelResult2 = rngResult
		3:
			reelResult3 = rngResult
	if receivedHowManyTimes <3:
		#print(receivedHowManyTimes)
		pass
		
	else:
		receivedHowManyTimes = 0
		_calculateWinning()


func _calculateWinning():
	var betText = $betAmount.text

	# Remove the dollar sign and convert the remaining string to an integer
	var betValue = int(betText.substr(1, betText.length() - 1))
	
	print("ReelResult1: ", reelResult1, " ReelResult2: ", reelResult2, " ReelResult3: ", reelResult3,)
	
	if reelResult1 == reelResult2 || reelResult2 == reelResult3:
		winningMultiplier = 5
	elif  reelResult1 == reelResult2 && reelResult2 == reelResult3:
		winningMultiplier = 100
	# you get a 7
	elif reelResult1 == 0 || reelResult2 == 0 || reelResult3 == 0:
		winningMultiplier = 1  
	elif reelResult1 != reelResult2 && reelResult2 != reelResult3 && reelResult1 != reelResult3:
		winningMultiplier = 0


	betResult = betValue * winningMultiplier
	print(str(betResult))
	PlayerVariables.money += betResult
	updatePlayerCash()


func _on_spin_button_up():
	print(PlayerVariables.money)
	if(PlayerVariables.money >= betSize):
		spinAnimation.play("spin")
		spinSound.play()
		SignalBank.startRoll.emit(1,3.5)
		SignalBank.startRoll.emit(2,3.5)
		SignalBank.startRoll.emit(3,3.5)
		PlayerVariables.money -= betSize
		updatePlayerCash()
		



func _on_increase_bet_button_up():
	betSize += 50 
	betLabel.text = "$" + str(betSize) 


func _on_decrease_bet_button_up():
	if(betSize > 0):
		betSize -= 50
	betLabel.text = "$" + str(betSize) 
	
	
func updatePlayerCash():
	var tween = create_tween()
	tween.tween_property(resultLabel, "position", Vector2(2,2), 1)
	#tween.interpolate_property()
	resultLabel.text = "$" + str(PlayerVariables.money)
