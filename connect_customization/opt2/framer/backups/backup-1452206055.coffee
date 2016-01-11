# Import file "0107-Prototype-Option3"
sketch = Framer.Importer.load("imported/0107-Prototype-Option3@1x")
scroll = ScrollComponent.wrap(sketch.content)

# Array-ing layers
labelLayers = sketch.LeftPanelLayers.subLayers
dimOpacity = 0.6
fullOpacity = 1
maxLeft = 10
currentLeft = 10

# Managing available labels & Splitting them to full and dim layer arrays
dimLayers = []
fullLayers = []

for layer, index in labelLayers[currentLeft..]
	layer.opacity = dimOpacity
	dimLayers.push layer
	
for layer, index in labelLayers[0..currentLeft-1]
	fullLayers.push layer

sketch.QuickFactsTitle.style = 
	"color" : "#333"
	"font-size" : "15px"
displayTitleLeft = () ->
	sketch.QuickFactsTitle.html = "Quick Facts " + currentLeft + "/" + maxLeft
# Display Functions
redisplayTop = ()->
	for layer,index in fullLayers
		layer.y = index * 23
	#sketch.LeftRect.scaleY = (fullLayers.length*25 + 50) / 280
originalLeftHeight = sketch.LeftBottomBg.height
redisplayBottom = ()->
	sketch.LeftBottomBg.y = sketch.TopBackground.y + (sketch.TopBackground.height + dimLayers.length*25) - originalLeftHeight + 35
	for layer,index in dimLayers
		layer.y = index * 25 + sketch.TopBackground.height - 30	
displayTitleLeft()
redisplayTop()
redisplayBottom()
sketch.LeftRect.originY = 0

# Animation & Clicking
for layer, index in labelLayers
	layer.on Events.Click, (event, layerClicked)->
		if layerClicked.opacity == dimOpacity
			if currentLeft < maxLeft
				layerClicked.opacity = fullOpacity
				currentLeft = currentLeft + 1
				displayTitleLeft()
				# Reshuffle Layers & Moving
				clickedIndex = dimLayers.indexOf(layerClicked)
				dimLayers.splice clickedIndex, 1 if clickedIndex isnt -1
				fullLayers.push layerClicked
				# Redisplay
				redisplayBottom()
				redisplayTop()
		else
			#Turning off this layer
			if currentLeft > 1
				layerClicked.animate
					properties:
						opacity: dimOpacity
					time: 0.3
					curve: "ease-in-out"
				currentLeft = currentLeft - 1
				displayTitleLeft()
				# Reshuffle Layers & Moving 
				clickedIndex = fullLayers.indexOf(layerClicked)
				fullLayers.splice clickedIndex, 1 if clickedIndex isnt -1
				dimLayers.push layerClicked
				# Redisplay
				redisplayBottom()
				redisplayTop()
	layer.on Events.MouseOver, (event, layerOvered)->
		sketch.HelpOver.visible = true
		sketch.HelpOver.x = event.clientX		
		sketch.HelpOver.y = layerOvered.y + sketch.TopBackground.y + 15
	layer.on Events.MouseOut, (event, layerOvered)->
		sketch.HelpOver.visible = false
		

# ---- MIDDLE PANEL ---- #
middleStates = [sketch.Middle1, sketch.Middle2, sketch.Middle3]
clickingMiddle = 0

for layer, index in middleStates
	if index > 0
		layer.visible= false
	layer.on Events.Click, (event, layerClicked)->
		# Find out which layer it is
		layerClicked.visible = false
		if clickingMiddle < middleStates.length - 1
			clickingMiddle++
			middleStates[clickingMiddle].visible = true
		else
			middleStates[0].visible = true
			clickingMiddle = 0
			
				
