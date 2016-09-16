# Disable hints
Framer.Extras.Hints.disable()
Framer.Extras.Preloader.setLogo("https://radiusintel-wpengine.netdna-ssl.com/wp-content/themes/vate/src/serve/assets/images/common/radius-logo.svg")

# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: "Segment Single"
	author: "Hang Le"
	twitter: ""
	description: ""


# Import file "Chart11-ForDemo1"
sketch = Framer.Importer.load("imported/Chart11-ForDemo1@1x")
# Use desktop cursor
document.body.style.cursor = "auto"

#Make interactive
makeInteractive = (object) ->
	object.onMouseOver ->
		document.body.style.cursor = "pointer"
	object.onMouseOut ->
		document.body.style.cursor = "auto"

# Make scroll
# Include a Layer 
scroll = ScrollComponent.wrap(sketch.Venn_Multiselection)
scroll.width = Screen.width
scroll.height = Screen.height
scroll.mouseWheelEnabled = true
scroll.scrollHorizontal = false


# Getting checkboxes
leftCheckboxes = [sketch.MyNew, sketch.MyOpen, sketch.MyWon, sketch.MyLost]
rightCheckboxes = [sketch.PartnerNew, sketch.PartnerOpen, sketch.PartnerWon, sketch.PartnerLost]

leftOnState = [true, false, false, false]
RightOnState = [true, false, false, false]
overlaps = [[278000,1500,5000,16500],[48000,10000,2000,10000],[1000,6000,1000,2000],[5000,4800,7000,3000]]

#Setting up venns
leftVenn = sketch.LeftVenn
rightVenn = sketch.RightVenn
middleX = sketch.VennMaximum.width - leftVenn.width/2
vennSize = [0.67,0.8,1] #in percentage
maxDistance = sketch.VennMaximum.width
leftVenn.style =
	"mix-blend-mode" : "multiply"
rightVenn.style =
	"mix-blend-mode" : "multiply"
opacityValue = [0.5, 0.66, 0.84, 1]
opacityMaxRange = [0.25, 0.5, 0.75, 1]
leftOpacity = 1 
rightOpacity = 1


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
partnerRecords = [450000, 16500, 8500, 25000]

myText = sketch.MyNumber
partnerText = sketch.PartnerNumber
overlapText = sketch.OverlapNumber

overlapText.style =
    "font-family": "Apex New, Helvetica",
    "font-size": "22px",
    "color": "#333",
    "text-align": "center",
    "font-weight" : "500"
    
placeText = () ->
	leftTotal = 0
	rightTotal = 0
	overlap = 0
	for value, index in leftOnState
		if(value)
			leftTotal += myRecords[index]
			for value2, index2 in RightOnState
				if(value2)
					overlap += overlaps[index][index2]
	for value,index in RightOnState
		rightTotal += partnerRecords[index]			
	
	#Generating random overlap & Sizing
	#if(leftTotal > rightTotal)
	#	overlap = Math.floor(Math.random()*rightTotal)
	#else
	#	overlap = Math.floor(Math.random()*leftTotal)
	overlapText.html = formatThousand(overlap)
	#Removing opacity
	#leftOpacity = opacity(leftTotal)
	#rightOpacity = opacity(rightTotal)
	randomizeCenter(leftTotal,rightTotal, overlap)

	#sizing(leftTotal, rightTotal)

sizing = (leftTotal, rightTotal) ->		
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

opacity = (total) ->	
	calculatedOpacity = total/500000
	for max, index in opacityMaxRange
		if(calculatedOpacity < max)
			calculatedOpacity = opacityValue[index]
			break
	return calculatedOpacity

randomizeCenter = (leftTotal,rightTotal,overlap) ->
	#Changing venn to null if not selected - doing opacity
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
	
	#Randomize venn
	leftDistance = (leftVenn.width * leftVenn.scale)/2
	rightDistance = (rightVenn.width * leftVenn.scale)/2
	distanceFromCenter = 50
	if(rightTotal < leftTotal)
		if(rightTotal != 0)
			rightDistance *= (1 - overlap/rightTotal)
			distanceFromCenter = rightDistance
	else
		if(leftTotal != 0)
			leftDistance *= (1 - overlap/leftTotal)
			distanceFromCenter = leftDistance	
	leftVenn.animate
		properties: 
			x: - distanceFromCenter
			opacity: leftOpacity
		time:0.5
	rightVenn.animate
		properties: 
			x: distanceFromCenter
			opacity: rightOpacity
		time:0.5
	console.log("Left side opacity: " + leftOpacity + "; Right side opacity: " + rightOpacity)

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

#Deploy button
DeployButton = sketch.DeployButton
deployDropdown = sketch.Deploy_Dropdown
sfdc = sketch.SF
csv = sketch.CSV
sfdc.children[1].opacity = 0
csv.children[1].opacity = 0
sfdc.onMouseOver ->
	sfdc.children[1].opacity = 1
	sfdc.children[0].opacity = 0
sfdc.onMouseOut ->
	sfdc.children[1].opacity = 0
	sfdc.children[0].opacity = 1
csv.onMouseOver ->
	csv.children[1].opacity = 1
	csv.children[0].opacity = 0
csv.onMouseOut ->
	csv.children[1].opacity = 0
	csv.children[0].opacity = 1

deployDropdown.opacity = 0
makeInteractive(sfdc)
makeInteractive(csv)
makeInteractive(DeployButton)
DeployButton.onClick ->
	deployDropdown.opacity = 1
sfdc.onClick ->
	#Go to deployment in Marvel
	window.location.href = 'https://marvelapp.com/1c2bga9/screen/15224413'	


