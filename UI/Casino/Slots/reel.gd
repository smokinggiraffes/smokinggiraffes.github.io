extends Node2D


#@export var slotItemCount : int = 10
#@export var spriteSize : int = 16
@export var slotItemCount : int = 10
@export var spriteSize : int = 25
@export var totalSize : int = 236
@export var sizeOffset : int = 12

@onready var upperReel = $upperReel
@onready var lowerReel = $lowerReel
var TWN
var MS = 20
var state
enum {ROLL, STOP, ROLLBACK}
var rollDuration = 3
var rollBackDuration = 0.5
@export var reelId : int

func _ready():
	SignalBank.startRoll.connect(Callable(self, "_startRoll"))
	upperReel.position.y = -250
	lowerReel.position.y = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("ui_accept"):
		_startRoll(reelId,5)
		#print("rollMe")
	
	match state:
		ROLLBACK:
			_roll(upperReel,-MS)
			_roll(lowerReel,-MS)
			
			rollBackDuration -= delta
			if rollBackDuration <= 0:
				state = ROLL
		ROLL:
			_roll(upperReel,MS)
			_roll(lowerReel,MS)
			
			rollDuration -= delta
			if rollDuration <= 0:
				state = STOP
				_stopRoll()
		STOP:
			pass



func _startRoll(reelNumber,dur):
	if reelNumber!= reelId : return
	upperReel.position.y = -250
	lowerReel.position.y = 0
	state = ROLLBACK
	rollDuration = dur
	rollBackDuration = 0.25
	

func _roll(slot:Sprite2D,MSpeed):
	var newPOS2 = slot.position.y + MSpeed
	if newPOS2 >= 250:
		newPOS2 = -250
	slot.position.y = newPOS2
	
	

func _stopRoll():
	TWN = create_tween().set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT).set_parallel()
	var rng = randi_range(0,9)
	var dur = 1.5
	
	var finalPos = -spriteSize*rng
	
	var finalSlot
	var anotherSlot
	if upperReel.position.y < lowerReel.position.y:
		finalSlot = upperReel
		anotherSlot = lowerReel
	else:
		finalSlot = lowerReel
		anotherSlot = upperReel
		
	
	
	finalSlot.z_index = 1
	anotherSlot.z_index = 0
	TWN.tween_property(finalSlot,"position:y",finalPos,dur)
	TWN.tween_property(anotherSlot,"position:y",finalPos+250,dur)
	await TWN.finished
	#print("Reel ID",reelId," reel Image ", finalSlot.name ," POS : ",finalPos, " RNJESUS :",rng)
	SignalBank.rollFinished.emit(reelId, rng)

