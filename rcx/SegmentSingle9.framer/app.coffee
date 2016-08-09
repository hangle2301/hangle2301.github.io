# Use desktop cursor
document.body.style.cursor = "auto"

# Import file "Chart8"
sketch = Framer.Importer.load("imported/Chart8@1x")

# Getting checkboxes
leftCheckboxes = [sketch.MyNew, sketch.MyOpen, sketch.MyWon, sketch.MyLost]
rightCheckboxes = [sketch.PartnerNew, sketch.PartnerOpen, sketch.PartnerWon, sketch.PartnerLost]

leftOnState = [true, false, false, false]
RightOnState = [true, false, false, false]

leftVenn = sketch.LeftVenn
rightVenn = sketch.RightVenn
middleX = sketch.VennMaximum.width/2
vennSize = [0.67,0.8,1] #in percentage

for checkboxGroup in leftCheckboxes
	checkboxGroup.onMouseOver ->
			document.body.style.cursor = "pointer"
	checkboxGroup.onMouseOut ->
			document.body.style.cursor = "auto"
	checkboxGroup.onClick ->
		index = leftCheckboxes.indexOf(this)
		if(leftOnState[index])
			leftOnState[index] = false
		else
			leftOnState[index] = true
		tick()
for checkboxGroup in rightCheckboxes
	checkboxGroup.onMouseOver ->
			document.body.style.cursor = "pointer"
	checkboxGroup.onMouseOut ->
			document.body.style.cursor = "auto"
	checkboxGroup.onClick ->
		index = rightCheckboxes.indexOf(this)
		if(RightOnState[index])
			RightOnState[index] = false
		else
			RightOnState[index] = true
		tick()

# DOING THE NUMBERS
myRecords = [300000, 100000, 75000, 25000]
partnerRecords = [450000, 25000, 10000, 15000]

myText = sketch.MyNumber
partnerText = sketch.PartnerNumber
overlapText = sketch.OverlapNumber

myText.style =
    "font-family": "Apex New, Helvetica",
    "font-size": "22px",
    "color": "#333",
    "text-align": "center",
    "font-weight" : "500"
partnerText.style =
    "font-family": "Apex New, Helvetica",
    "font-size": "22px",
    "color": "#333",
    "text-align": "center",
    "font-weight" : "500"
overlapText.style =
    "font-family": "Apex New, Helvetica",
    "font-size": "22px",
    "color": "#333",
    "text-align": "center",
    "font-weight" : "500"
    
placeText = () ->
	leftTotal = 0
	rightTotal = 0
	for value, index in leftOnState
		if(value)
			leftTotal += myRecords[index]
	for value, index in RightOnState
		if(value)
			rightTotal += partnerRecords[index]
	
	myText.html = formatThousand(leftTotal)
	partnerText.html = formatThousand(rightTotal)
	#Generating random overlap & Sizing
	if(leftTotal > rightTotal)
		overlap = Math.floor(Math.random()*rightTotal)
	else
		overlap = Math.floor(Math.random()*leftTotal)
	overlapText.html = formatThousand(overlap)
	randomizeCenter(leftTotal,rightTotal, overlap)
		
randomizeCenter = (leftTotal,rightTotal,overlap) ->
	#Changing venn to null if not selected
	if(leftTotal == 0)
		leftVenn.children[1].opacity = 0
		leftVenn.children[0].opacity = 1
	else
		leftVenn.children[1].opacity = 1
		leftVenn.children[0].opacity = 0
	if(rightTotal == 0)
		rightVenn.children[1].opacity = 0
		rightVenn.children[0].opacity = 1
	else
		rightVenn.children[1].opacity = 1
		rightVenn.children[0].opacity = 0
	#Animating on sizing
	if(leftTotal == rightTotal)
		leftVenn.scale = vennSize[2]
		rightVenn.scale = vennSize[2]
	else if(leftTotal > rightTotal)
		if(leftTotal/rightTotal > 1.5)
			leftVenn.scale = vennSize[2]
			rightVenn.scale = vennSize[0]
		else
			leftVenn.scale = vennSize[2]
			rightVenn.scale = vennSize[1]
	else
		if(rightTotal/leftTotal > 1.5)
			rightVenn.scale = vennSize[2]
			leftVenn.scale = vennSize[0]
		else
			rightVenn.scale = vennSize[2]
			leftVenn.scale = vennSize[1]

	#Randomize venn
	distanceFromCenter = 50
	if(leftTotal > rightTotal)
		if(rightTotal != 0)
			distanceFromCenter = Math.floor(overlap/rightTotal * rightVenn.width / 2)
			#distanceFromCenter = Math.floor(Math.random()*50)
	else
		if(leftTotal != 0)
			distanceFromCenter = Math.floor(overlap/leftTotal * leftVenn.width / 2)
			#distanceFromCenter = Math.floor(Math.random()*50) 
	
	leftVenn.animate
		properties: 
			x: middleX + distanceFromCenter - leftVenn.width/2
		time:0.5
	rightVenn.animate
		properties: 
			x: middleX - distanceFromCenter + rightVenn.width/2
		time:0.5

formatThousand = (number) ->
	string = number
	if(number > 1000)
		firstPart =  Math.floor(number/1000)
		secondPart = Math.floor((number/1000 - firstPart) * 1000)
		if(secondPart == 0)
			secondPart = "000"
		else if(secondPart < 100)
			secondPart = secondPart.toString() + "0"
		else if(secondPart < 10)
			secondPart = secondPart.toString() + "00"
		string = firstPart + "," + secondPart
	return string

# Do the state changes	
tick = () ->
	for value, index in leftOnState
		if(!value)
			leftCheckboxes[index].children[0].opacity = 1
			leftCheckboxes[index].children[1].opacity = 0
		else
			leftCheckboxes[index].children[0].opacity = 0
			leftCheckboxes[index].children[1].opacity = 1
	for value2, index2 in RightOnState
		if(!value2)
			rightCheckboxes[index2].children[0].opacity = 1
			rightCheckboxes[index2].children[1].opacity = 0
		else
			rightCheckboxes[index2].children[0].opacity = 0
			rightCheckboxes[index2].children[1].opacity = 1
	placeText()					
# Initial run
tick()
