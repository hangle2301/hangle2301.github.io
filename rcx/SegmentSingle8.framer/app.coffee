# Import file "Chart7"
sketch = Framer.Importer.load("imported/Chart7@1x")
# Use desktop cursor
document.body.style.cursor = "auto"

leftSelection = [sketch.LeftNewSelection, sketch.LeftOpenSelection, sketch.LeftWonSelection, sketch.LeftLostSelection]
rightSelection = [sketch.RightNewSelection, sketch.RightOpenSelection, sketch.RightWonSelection, sketch.RightLostSelection]

leftShowGroup = [sketch.NewGroup, sketch.OpenGroup, sketch.WonGroup, sketch.LostGroup]

# Creating venns
leftVenn = [new Array(), new Array(), new Array(), new Array()]
rightVenn = [new Array(), new Array(), new Array(), new Array()]
leftHover = sketch.MyBreakdown
rightHover = sketch.PartnerBreakdown

#Preparing 
for group, indexGroup in leftShowGroup
	for layer in group.children[0..3]
		layer.opacity = 0
		# Creating venns
		leftVenn[indexGroup].push(layer.children[2])
		layer.children[2].originalX = layer.children[2].x
		# Right venns
		rightVenn[indexGroup].push(layer.children[1])
		layer.children[1].originalX = layer.children[1].x
#Interaction
hover = false
leftHover.opacity = 0
rightHover.opacity = 0
currentShow = leftShowGroup[0].children[0]
currentLeftVenn = leftVenn[0][0]
currentRightVenn = rightVenn[0][1]
currentShow.opacity = 1
leftSelected = 0
rightSelected = 0


for layer,index in leftSelection
	layer.onClick ->
		leftSelected = leftSelection.indexOf(this)
		doShow()
	layer.onMouseOver ->
		document.body.style.cursor = "pointer"
	layer.onMouseOut ->
		document.body.style.cursor = "auto"
	
for layer,index in rightSelection
	layer.onClick ->
		console.log(this)
		rightSelected = rightSelection.indexOf(this)
		doShow()
	layer.onMouseOver ->
		document.body.style.cursor = "pointer"
	layer.onMouseOut ->
		document.body.style.cursor = "auto"

#Figuring out which layer to turn on
resetLayer = (event, layer) ->
	console.log(event)
	#layer.x = layer.originalX
doShow = () ->
	console.log("Selecting " + leftSelected + " " + rightSelected)
	#Going Out
	currentShow.animate
		properties:
			opacity: 0
		time: 0.7
		curve: "easeout"
	#Venn animations, left side
	currentLeftVenn.animate
		properties:
			x: leftVenn[leftSelected][rightSelected].x
		time: 0.7
	currentLeftVenn.on Events.AnimationEnd, (animation, thisLayer) ->
		thisLayer.x = thisLayer.originalX
	currentLeftVenn = leftVenn[leftSelected][rightSelected]
	#Venn animations, right side
	currentRightVenn.animate
		properties:
			x: rightVenn[leftSelected][rightSelected].x
		time: 0.7
	currentRightVenn.on Events.AnimationEnd, (animation, thisLayer) ->
		thisLayer.x = thisLayer.originalX
	currentRightVenn = rightVenn[leftSelected][rightSelected]
 		
	#Going In
	currentShow = leftShowGroup[leftSelected].children[rightSelected]
	currentShow.animate
		properties:
			opacity:1
		time: 0.5
		delay: 0.3
		curve: "easein"
	

# Do the hovering
sketch.MyBreakdownHover.onMouseOver ->
	leftHover.animate
		properties: 
			opacity: 1
		time: 0.5
sketch.MyBreakdownHover.onMouseOut ->
	leftHover.animate
			properties: 
				opacity: 0
			time: 0.5

sketch.PartnerBreakdownHover.onMouseOver ->
	rightHover.animate
		properties: 
			opacity: 1
		time: 0.5
sketch.PartnerBreakdownHover.onMouseOut ->	
	rightHover.animate
		properties: 
			opacity: 0
		time: 0.5
		