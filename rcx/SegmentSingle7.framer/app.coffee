# Use desktop cursor
document.body.style.cursor = "auto"

# Import file "Chart6"
sketch = Framer.Importer.load("imported/Chart6@1x")

leftSelection = [sketch.LeftNewSelection, sketch.LeftOpenSelection, sketch.LeftWonSelection, sketch.LeftLostSelection]
rightSelection = [sketch.RightNewSelection, sketch.RightOpenSelection, sketch.RightWonSelection, sketch.RightLostSelection]

leftShowGroup = [sketch.NewGroup, sketch.OpenGroup, sketch.WonGroup, sketch.LostGroup]
leftHover = [sketch.New_Hover_Left, sketch.Open_Hover_Left, sketch.Won_Hover_Left, sketch.Lost_Hover_Left]
rightHover = [sketch.New_Hover_Right, sketch.Open_Hover_Right, sketch.Won_Hover_Right, sketch.Lost_Hover_Right]
leftSelected = 0
rightSelected = 0
currentShow = leftShowGroup[0].children[0]
#Preparing 
for group in leftShowGroup
	for layer in group.children[0..3]
		layer.opacity = 0
		console.log("Layer " + layer.name)
currentShow.opacity = 1

#Interaction
hover = true
currentHover = -1
currentRightHover = -1
for layer in leftHover
	layer.opacity = 0
for layer in rightHover
	layer.opacity = 0
	
for layer,index in leftSelection
	layer.onClick ->
		leftSelected = leftSelection.indexOf(this)
		doShow()
	layer.onMouseOver ->
		document.body.style.cursor = "pointer"
		if(hover)
			currentHover = leftHover[leftSelection.indexOf(this)]
			currentHover.animate
				properties:
					opacity:1			
				time: 0.5
				curve: "spring"
	layer.onMouseOut ->
		document.body.style.cursor = "auto"
		if(hover)
			if(currentHover != -1)
				currentHover.animate
					properties:
						opacity: 0		
					time: 0.3
			currentHover = -1

	
for layer,index in rightSelection
	layer.onClick ->
		rightSelected = rightSelection.indexOf(this)
		doShow()
	layer.onMouseOver ->
		document.body.style.cursor = "pointer"
		if(hover)
			currentRightHover = rightHover[rightSelection.indexOf(this)]
			currentRightHover.animate
				properties:
					opacity:1			
				time: 0.5
				curve: "spring"
	layer.onMouseOut ->
		document.body.style.cursor = "auto"
		if(hover)
			if(currentRightHover != -1)
				currentRightHover.animate
					properties:
						opacity: 0		
					time: 0.3
			currentRightHover = -1
#Figuring out which layer to turn on
doShow = () ->
	console.log(leftSelected + " " + rightSelected)
	#Going Out
	currentShow.animate
		properties:
			opacity: 0
		time: 0.5
	#Going In
	currentShow = leftShowGroup[leftSelected].children[rightSelected]
	currentShow.animate
		properties:
			opacity:1
		time: 0.5
		curve: "spring"
		