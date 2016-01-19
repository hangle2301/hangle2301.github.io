# Import file "0119-Prototype"
sketch = Framer.Importer.load("imported/0119-Prototype@1x")

scroll = new ScrollComponent
    width: Framer.Device.screen.width
    height: Framer.Device.screen.height
scroll.mouseWheelEnabled = true
# Include a Layer 
sketch.Artboard.superLayer = scroll.content

# Mode-ing
# ----- PREVIEW INTERACTION ---- #
editState = sketch.Editstate
previewPanel = sketch.Preview
previewButton = sketch.PreviewButton
flippedEditButton = sketch.EditBt
flippedSaveButton = sketch.SaveBt	
rightPanelPreview = sketch.PreviewRightPanel
tooltips = sketch.Tooltip.subLayers

# Initial state
previewPanel.visible = false

previewButton.on Events.Click, (event, layerClicked)->
	previewPanel.visible = true
	editState.visible = false
flippedEditButton.on Events.Click, (event, layerClicked)->
	previewPanel.visible = false
	editState.visible = true
rightPanelPreview.on Events.Click, (event, layerClicked)->
	if (rightPanelPreview.opacity == 0)
		rightPanelPreview.opacity = 1
	else
		rightPanelPreview.opacity = 0

# ----- LEFT PANEL INTERACTION ---- #
# Managing available labels
labelLayers = sketch.LeftPanelList.subLayers
maxLeft = 9
currentLeft = 0
for layer, index in labelLayers
	layer.subLayersByName("hover")[0].opacity = 0
	layer.subLayersByName("selected")[0].opacity = 0
for layer, index in labelLayers[0..4]
	layer.subLayersByName("selected")[0].opacity = 1
	layer.subLayersByName("hover")[0].opacity = 1
	currentLeft = currentLeft + 1
	
sketch.QuickFactsTitle.style = 
	"color" : "#969DA3"
	"font-size" : "14px"
	"font-style" : "Italic"
	"font-family" : "Apex New"
displayTitleLeft = () ->
	sketch.QuickFactsTitle.html = "(" + currentLeft + "/" + maxLeft + " Maximum Signals" + ")"
	
displayTitleLeft()

# Setup initial state
for layer, index in labelLayers
	layer.on Events.MouseOver, (event, layerOvered)->
		layerOvered.subLayersByName("hover")[0].animate
			properties:
				opacity: 1
			time: 0.3
			curve: "easeinout"
	layer.on Events.MouseOut, (event, layerOvered)->
		if (layerOvered.subLayersByName("selected")[0].opacity != 1)
			layerOvered.subLayersByName("hover")[0].animate
				properties:
					opacity: 0
				time: 0.3
				curve: "easeinout"
	layer.on Events.Click, (event, layerClicked)->
		if layerClicked.subLayersByName("selected")[0].opacity == 0
			#Turning on this layer
			if currentLeft < maxLeft
				layerClicked.subLayersByName("selected")[0].opacity = 1
				layerClicked.subLayersByName("hover")[0].opacity = 1
				currentLeft = currentLeft + 1
				displayTitleLeft()
		else
			#Turning off this layer
			if currentLeft > 1
				layerClicked.subLayersByName("selected")[0].opacity = 0
				layerClicked.subLayersByName("hover")[0].opacity = 0
				currentLeft = currentLeft - 1
				displayTitleLeft()

# ----- MIDDLE PANEL INTERACTION ---- #
maxMiddle = 3
currentMiddle = 0
middleLayers = sketch.MiddlePanelList.subLayers
# Managing available labels
for layer, index in middleLayers
	layer.subLayersByName("hover")[0].opacity = 0
	layer.subLayersByName("selected")[0].opacity = 0
for layer, index in middleLayers[3..4]
	layer.subLayersByName("selected")[0].opacity = 1
	layer.subLayersByName("hover")[0].opacity = 1
	currentMiddle = currentMiddle + 1


sketch.ComparisonTitle.style = 
	"color" : "#969DA3"
	"font-size" : "14px"
	"font-style" : "Italic"
	"font-family" : "Apex New"
displayTitleMiddle = () ->
	sketch.ComparisonTitle.html = "(" + currentMiddle + "/" + maxMiddle + " Maximum Signals" + ")"
	
displayTitleMiddle()

#List interaction
sketch.MiddlePanelTooltip.opacity = 0
for layer, index in middleLayers
	layer.on Events.MouseOver, (event, layerOvered)->
		layerOvered.subLayersByName("hover")[0].animate
			properties:
				opacity: 1
			time: 0.3
			curve: "easeinout"
		sketch.MiddlePanelTooltip.animate
			properties:
				opacity: 1
		sketch.MiddlePanelTooltip.x = layerOvered.x + sketch.MiddlePanelList.x + 100
		sketch.MiddlePanelTooltip.y = layerOvered.y + sketch.MiddlePanelList.y - 25
				
	layer.on Events.MouseOut, (event, layerOvered)->
		if (layerOvered.subLayersByName("selected")[0].opacity != 1)
			layerOvered.subLayersByName("hover")[0].animate
				properties:
					opacity: 0
				time: 0.3
				curve: "easeinout"
		sketch.MiddlePanelTooltip.animate
			properties:
				opacity: 0
	layer.on Events.Click, (event, layerClicked)->
		if layerClicked.subLayersByName("selected")[0].opacity == 0
			#Turning on this layer
			if currentMiddle < maxMiddle
				layerClicked.subLayersByName("selected")[0].opacity = 1
				layerClicked.subLayersByName("hover")[0].opacity = 1
				currentMiddle = currentMiddle + 1
				displayTitleMiddle()
		else
			#Turning off this layer
			if currentMiddle > 1
				layerClicked.subLayersByName("selected")[0].opacity = 0
				layerClicked.subLayersByName("hover")[0].opacity = 0
				currentMiddle = currentMiddle - 1
				displayTitleMiddle()
				
# ----- TOOLTIP INTERACTION ---- #
for layer, index in tooltips
	layer.subLayersByName("tip")[0].opacity = 0
	layer.subLayersByName("question")[0].on Events.MouseOver, (event,layerOvered) ->
		layerOvered.siblingLayers[0].animate
			properties:
				opacity: 1
	layer.subLayersByName("question")[0].on Events.MouseOut, (event,layerOvered) ->
		layerOvered.siblingLayers[0].animate
			properties:
				opacity: 0

# ----- NEARBY TITLE INTERACTION ---- #		
nearbyCursor = sketch.NearbyCursor
nearbyEdit = sketch.NearbyEdit
nearbyCursor.visible = false

nearbyEdit.on Events.Click, (event, layerClicked)->
	if (!nearbyCursor.visible)
		nearbyCursor.visible = true
		nearbyEdit.visible = false
nearbyCursor.on Events.Click, (event, layerClicked)->
		nearbyCursor.visible = false
		nearbyEdit.visible = true
		
	


