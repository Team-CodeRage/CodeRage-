extends Node2D

var spriteNode
var primaryNode
var labelNode
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

var can_drag = false
var dragging = false
var mouse_to_center_set = false
var mouse_to_center
var sprite_pos
var mouse_pos

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
		if(wasSet):
			if(tryNewGrid()):
				setPosition()
			else:
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
	spriteNode = get_node("Sprite")
	primaryNode = get_node("Sprite/PrimaryColor")
	labelNode = get_node("Label")
	pass # Replace with function body.

func setGridLength(numBlocks):
	var newScale = Vector2((numBlocks * .4) - .04, 0.359)
	#var newScale = Vector2(((numBlocks * .4) + 0.359), 0.359)
	gridLength = numBlocks
	spriteNode.set_scale(newScale)
	var offset = 4
	primaryNode.set_scale(Vector2(1/newScale.x, 1/newScale.y))
	print("newScale: ", newScale)
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
	var newScale = labelNode.get_size().x
	newScale = ceil(newScale / 36)
	setGridLength(newScale)
	pass # Replace with function body.

func checkGrids(row, startCol, numCols):
	print("row: ", row.name)
	print("startCol: ", startCol.name)
	print("numCols: ", numCols)
	for i in range(int(startCol.name), (numCols + int(startCol.name))):
		if(row.get_node(str(i)).available == false):
			print("Check false")
			return false
	print("Check true")
	return true

func fillGrids(row, startCol, numCols):
	for i in range(int(startCol.name), (numCols + int(startCol.name))):
		row.get_node(str(i)).available = false;
	return true

func freeGrids(row, startCol, numCols):
	for i in range(int(startCol.name), (numCols + int(startCol.name))):
		row.get_node(str(i)).available = true;
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
	if(area.name == "storeArea2d"):
		print("want's to sell")
	elif(area.name == "placementArea2d"):
		posToCheckRow = area.get_parent().get_parent()
		posToCheckCol = area.get_parent()
		wasSet = true
	pass # Replace with function body.

func _on_PlacerArea2D_area_exited(area):
	pass # Replace with function body.
