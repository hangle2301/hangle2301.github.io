# Import file "0106-Prototype"
sketch = Framer.Importer.load("imported/0106-Prototype@1x")
scroll = new ScrollComponent
    width: Framer.Device.screen.width
    height: Framer.Device.screen.height
scroll.mouseWheelEnabled = true
# Include a Layer 
sketch.superLayer = scroll.content

# Array-ing layers
labelLayers = sketch.LeftPanelList.subLayers
dimOpacity = 0.4
fullOpacity = 1

# ----- LEFT PANEL INTERACTION ---- #
# Setup initial state
for layer, index in labelLayers[4..10]
	layer.opacity = dimOpacity	
sketch.HelpOver.visible = false

# Managing available labels
maxLeft = 10
currentLeft = 9
sketch.QuickFactsTitle.style = 
	"color" : "#333"
	"font-size" : "15px"
displayTitleLeft = () ->
	sketch.QuickFactsTitle.html = "Quick Facts " + currentLeft + "/" + maxLeft
	
displayTitleLeft()

# Label Interaction
for layer, index in labelLayers
	layer.on Events.Click, (event, layerClicked)->
		if layerClicked.opacity == dimOpacity
			#Turning on this layer
			if currentLeft < maxLeft
				layerClicked.animate
					properties:
						opacity: fullOpacity
					time: 0.3
					curve: "ease-in-out"
				currentLeft = currentLeft + 1
				displayTitleLeft()
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
			
	layer.on Events.MouseOver, (event, layerOvered)->
		sketch.HelpOver.visible = true
		sketch.HelpOver.x = event.clientX		
		sketch.HelpOver.y = layerOvered.y + 15
	layer.on Events.MouseOut, (event, layerOvered)->
		sketch.HelpOver.visible = false
		
# ----- MIDDLE PANEL INTERACTION ---- #
middleLayers = sketch.MiddlePanelList.subLayers
# Managing available labels
for layer, index in middleLayers[3..4]
	layer.opacity = dimOpacity
maxMiddle = 3
currentMiddle = 3
sketch.ComparisonTitle.style = 
	"color" : "#333"
	"font-size" : "15px"
displayTitleMiddle = () ->
	sketch.ComparisonTitle.html = "Advanced Signals " + currentMiddle + "/" + maxMiddle
	
displayTitleMiddle()
sketch.MiddleFlip.opacity = 0

#List interaction
for layer, index in middleLayers
	layer.on Events.Click, (event, layerClicked) ->
		if layerClicked.opacity == dimOpacity
			#Turning on this layer
			if currentMiddle < maxMiddle
				layerClicked.animate
					properties:
						opacity: fullOpacity
					time: 0.3
					curve: "ease-in-out"	
				currentMiddle = currentMiddle + 1
				displayTitleMiddle()
				if (currentMiddle == 2)
					sketch.MiddleFlip.animate
						properties:
							opacity: 0
						time: 0.5
						curve: "ease-in-out"
		else
			#Turning off this layer
			if currentMiddle > 1
				layerClicked.animate
					properties:
						opacity: dimOpacity
					time: 0.3
					curve: "ease-in-out"	
				currentMiddle = currentMiddle - 1
				displayTitleMiddle()
				#When there's only 1 pack selected in the middle part
				if currentMiddle == 1
					sketch.MiddleFlip.animate
						properties:
							opacity: 1
						time: 0.5
						curve: "ease-in-out"
						

# ----- OTHER INTERACTION ---- #
sketch.PreviewScreen.opacity = 0
sketch.Preview.on Events.Click, (event, layer) ->
	#Preview layer
	sketch.Edit.visible = true
	sketch.PreviewScreen.animate
		properties:
			opacity: 1
		time: 0.5
		curve: "ease-in-out"
	sketch.Edit.on Events.Click, (event, layer) ->
		sketch.Edit.visible = false
		sketch.PreviewScreen.animate
			properties:
				opacity: 0
			time: 0.5
			curve: "ease-in-out"
	
		
	
	