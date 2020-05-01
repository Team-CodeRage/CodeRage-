extends KinematicBody2D

onready var spriteNode = get_node("Node2D/Sprite")
onready var primaryNode = get_node("Node2D/Sprite/PrimaryColor")
onready var labelNode = get_node("Node2D/Label")
onready var animPlayer = get_node("Node2D/AnimationPlayer")

var positionNodeR
var positionNodeC
var gridLength = 5
var mouseIn = false
var purchased = false
var positionSet = false
var posToCheckRow
var posToCheckCol
var wasSet = false
var wasPlaced = false
var spotFilled = false
var motion = Vector2()
var canSell = false
var pixelLength
var solutionNum
var price = 10

var can_drag = false
var dragging = false
var mouse_to_center_set = false
var mouse_to_center
var sprite_pos
var mouse_pos

func _physics_process(delta):
	motion.y += 0.5
	move_and_slide(motion)
	pass

func _process(delta):
	if (mouseIn && Input.is_action_pressed("LeftClick")): #When clicking
		#First we set mouse_to_center as a static vector
		#for preventing the sprite to move its center to the mouse position
		if not mouse_to_center_set:
			sprite_pos = self.position
			mouse_pos = get_viewport().get_mouse_position()
			mouse_to_center = restaVectores(sprite_pos, mouse_pos)
			mouse_to_center_set = true
		#We set the dragging to true if it's allowed to
		dragging = can_drag

	if (dragging && Input.is_action_pressed("LeftClick")): #While dragging
		if can_drag:
			mouse_pos = get_viewport().get_mouse_position()
			if(purchased == false):
				buyItem()
			if(spotFilled):
				freeGrids(positionNodeR, positionNodeC, gridLength)
			setZPos(1)
			primaryNode.show()
			#Set the position of the sprite to
			#mouse position + static mouse_to_center vector
			var position = sumaVectores(mouse_pos, mouse_to_center)
			set_position(position)
			
	else: #When we release
		setZPos(0)
		primaryNode.hide()
		mouse_to_center_set = false #Set this to false so we can set mouse_to_center again
		dragging = false
		if(canSell == true and wasPlaced == true):
			wasPlaced = false
			wasSet = false
			sellItem()
		elif(wasSet):
			if(tryNewGrid()):
				setPosition()
			elif(wasPlaced):
				fillGrids(positionNodeR, positionNodeC, gridLength)
		if(wasPlaced):
			setPosition()
			spotFilled = true

func _on_PickUpArea2D_mouse_entered():
	mouseIn = true
	get_parent()._add_sprite(self) #Add the sprite to the sprite list

func _on_PickUpArea2D_mouse_exited():
	mouseIn = false
	get_parent()._remove_sprite(self)  #Remove the sprite from the sprite list

func restaVectores(v1, v2): #vector substraction
	return Vector2(v1.x - v2.x, v1.y - v2.y)
	
func sumaVectores(v1, v2): #vector sum
	return Vector2(v1.x + v2.x, v1.y + v2.y)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func buyItem():
	get_node("Timer").stop()
	get_parent().buyBlock(price)
	purchased = true
	scale = Vector2(1, 1)
	set_physics_process(false)
	get_node("CollisionShape2D").disabled = true
	pass

func sellItem():
	get_node("Timer").stop()
	get_parent().sellBlock(price)
	animPlayer.play("Fade")
	pass

func setGridLength(numBlocks):
	var newScale = Vector2((numBlocks * .4) - .04, 0.359)
	#var newScale = Vector2(((numBlocks * .4) + 0.359), 0.359)
	gridLength = numBlocks
	spriteNode.set_scale(newScale)
	var offset = 4
	primaryNode.set_scale(Vector2(1/newScale.x, 1/newScale.y))
	primaryNode.get_node("ColorRect").set_size(Vector2(primaryNode.get_node("ColorRect").get_size().x * newScale.x + offset, labelNode.get_size().y + offset))
	pass

func getGridLength():
	return gridLength

func setText(text):
	labelNode.set_text(text)
	pass

func getText():
	return labelNode.get_text()

func setColor(color):
	spriteNode.set_self_modulate(color)
	pass
	
func getColor():
	return spriteNode.get_self_modulate()

func setPositionNode(newPosR, newPosC):
	positionNodeR = newPosR
	positionNodeC = newPosC
	wasPlaced = true
	pass

func getPositionNodeR():
	return positionNodeR.name

func getPositionNodeC():
	return positionNodeC.name

func setPosition():
	position = get_parent().get_parent().getBlockPos(getPositionNodeR(),getPositionNodeC())
	pass

func setZPos(num):
	if(num == 1):
		self.z_index = 1
	if(num == 0):
		self.z_index = 0
	pass

func _on_Label_resized():
	pixelLength = labelNode.get_size().x
	var newScale = ceil(pixelLength / 36)
	setGridLength(newScale)
	var windowSize = 159
	var labelSize = (newScale * 36)/2
	var totalSpace = windowSize - (labelSize)
	var spaceSide = (totalSpace) / 2
	position = Vector2(spaceSide + 30, 100)
	pass # Replace with function body.

func checkGrids(row, startCol, numCols):
	for i in range(int(startCol.name), (numCols + int(startCol.name))):
		if(row.get_node(str(i)).available == false):
			return false
	return true

func fillGrids(row, startCol, numCols):
	for i in range(int(startCol.name), (numCols + int(startCol.name))):
		row.get_node(str(i)).available = false
		row.get_node(str(i)).type = solutionNum
	return true

func freeGrids(row, startCol, numCols):
	for i in range(int(startCol.name), (numCols + int(startCol.name))):
		row.get_node(str(i)).available = true
		row.get_node(str(i)).type = -1
	return true

func tryNewGrid():
	if(((int(posToCheckCol.name) + gridLength) <= 14) and posToCheckCol.available == true):#check the next parts as well
		if(checkGrids(posToCheckRow, posToCheckCol, gridLength) == true):
			if(wasPlaced):
				freeGrids(positionNodeR, positionNodeC, gridLength)
			setPositionNode(posToCheckRow, posToCheckCol)
			fillGrids(posToCheckRow, posToCheckCol, gridLength)
			return true
	return false
	pass

func _on_PlacerArea2D_area_entered(area):
	if(area.name == "StoreArea2D"):
		canSell = true
	elif(area.name == "placementArea2d"):
		posToCheckRow = area.get_parent().get_parent()
		posToCheckCol = area.get_parent()
		wasSet = true
	pass # Replace with function body.

func _on_PlacerArea2D_area_exited(area):
	if(area.name == "StoreArea2D"):
		canSell = false
	pass # Replace with function body.

func _on_AnimationPlayer_animation_finished(anim_name):
	if(anim_name == "Fade"):
		queue_free()
	pass # Replace with function body.


func _on_Timer_timeout():
	price = price - 1
	if(price <= 0):
		get_node("Timer").stop()
		animPlayer.play("Fade")
	pass # Replace with function body.
