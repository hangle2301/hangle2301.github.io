# Import file "Customization-MVP"
sketch = Framer.Importer.load("imported/Customization-MVP@1x")

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
rightPanelPreview = sketch.PreviewRightPanel
tooltips = sketch.Tooltip.subLayers

# ----- LEFT PANEL INTERACTION ---- #
# Managing available labels
labelLayers = sketch.LeftPanelList.subLayers
maxLeft = 9
currentLeft = 0
for layer, index in labelLayers
	layer.subLayersByName("hover")[0].opacity = 0
	layer.subLayersByName("selected")[0].opacity = 0
	layer.clicked = false
for layer, index in labelLayers[0..5]
	layer.subLayersByName("selected")[0].opacity = 1
	currentLeft = currentLeft + 1
	layer.clicked = true

sketch.QuickFactsTitle.style = 
	"color" : "#969DA3"
	"font-size" : "14px"
	"font-style" : "Italic"
	"font-family" : "Apex New"
displayTitleLeft = () ->
	sketch.QuickFactsTitle.html = "(" + currentLeft + "/" + maxLeft + " Maximum Facts" + ")"
	
displayTitleLeft()

animateCheck= (layerToAnimate) ->
	animationA = new Animation
		layer: layerToAnimate
		properties:
			scale: 1.2
		time: 0.15
	animationB = animationA.reverse()
	animationA.on(Events.AnimationEnd, animationB.start)
	animationA.start()
	
# Setup initial state
for layer, index in labelLayers
	layer.on Events.MouseOver, (event, layerOvered)->
		layerOvered.subLayersByName("hover")[0].animate
			properties:
				opacity: 1
			time: 0.3
			curve: "easeinout"
	layer.on Events.MouseOut, (event, layerOvered)->
		layerOvered.subLayersByName("hover")[0].animate
			properties:
				opacity: 0
			time: 0.3
			curve: "easeinout"
	layer.on Events.Click, (event, layerClicked)->
		thisIndex = labelLayers.indexOf(layerClicked)
		if (!layerClicked.clicked)
			#Turning on this layer
			if currentLeft < maxLeft
				layerClicked.subLayersByName("selected")[0].opacity = 1
				animateCheck(layerClicked.subLayersByName("selected")[0])
				layerClicked.clicked = true
				currentLeft = currentLeft + 1
				displayTitleLeft()
		else
			#Turning off this layer
			if currentLeft > 1
				layerClicked.subLayersByName("selected")[0].opacity = 0
				layerClicked.clicked = false
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
	layer.clicked = false
for layer, index in middleLayers[1..3]
	layer.subLayersByName("selected")[0].opacity = 1
	currentMiddle = currentMiddle + 1
	layer.clicked = true


sketch.ComparisonTitle.style = 
	"color" : "#969DA3"
	"font-size" : "14px"
	"font-style" : "Italic"
	"font-family" : "Apex New"
displayTitleMiddle = () ->
	sketch.ComparisonTitle.html = "(" + currentMiddle + "/" + maxMiddle + " Maximum Profiles" + ")"
	
displayTitleMiddle()

#List interaction
middlePanelTooltips = sketch.middletooltip.subLayers
for layer, index in middlePanelTooltips
	layer.opacity = 0
for layer, index in middleLayers
	layer.on Events.MouseOver, (event, layerOvered)->
		layerIndex = middleLayers.indexOf(layerOvered)
		layerOvered.subLayersByName("hover")[0].animate
			properties:
				opacity: 1
			time: 0.3
			curve: "easeinout"
		middlePanelTooltips[layerIndex].animate
			properties:
				opacity: 1	
	layer.on Events.MouseOut, (event, layerOvered)->
		layerIndex = middleLayers.indexOf(layerOvered)
		layerOvered.subLayersByName("hover")[0].animate
			properties:
				opacity: 0
			time: 0.3
			curve: "easeinout"
		middlePanelTooltips[layerIndex].animate
			properties:
				opacity: 0
	layer.on Events.Click, (event, layerClicked)->
		if (!layerClicked.clicked)
			#Turning on this layer
			if currentMiddle < maxMiddle
				layerClicked.subLayersByName("selected")[0].opacity = 1
				animateCheck(layerClicked.subLayersByName("selected")[0])
				layerClicked.clicked = true
				currentMiddle = currentMiddle + 1
				displayTitleMiddle()
		else
			#Turning off this layer
			if currentMiddle > 1
				layerClicked.subLayersByName("selected")[0].opacity = 0
				layerClicked.clicked = false
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
		
# ----- SAVE STATE ---- #
previewSaveButton = sketch.PreviewStateSaveButton
editSaveButton = sketch.EditStateSaveButton	
cycle = (groupToCycle)->
	layerlist = groupToCycle.subLayers
	for layer, index in layerlist
		layer.animate
			properties:
				opacity: 0
			delay: (layerlist.length - index)
			time: 0.5
		layer.on Events.AnimationEnd, (animation, layerAnimated) ->
			console.log("ended " + layerAnimated)
			thisIndex = layerlist.indexOf(layerAnimated)
			layerAnimated.animate
				properties:
					opacity: 1	
				delay:(layerlist.length - thisIndex)
			layerAnimated.removeListener(Events.AnimationEnd)					
previewSaveButton.on Events.Click, (event, layerClicked)->
	cycle(previewSaveButton)
editSaveButton.on Events.Click, (event, layerClicked)->
	cycle(editSaveButton)

# Preview functionality
previewPanel.visible = false
previewLeftPanel = sketch.LeftPanelPreview.subLayers
previewRightPanel = sketch.previewThirdPanel.subLayers
previewMiddlePanel = sketch.MiddlePanelPreview.subLayers

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

clickingMiddle = 0
for layer, index in previewMiddlePanel
	if index > 0
		layer.visible= false
	layer.on Events.Click, (event, layerClicked)->
		# Find out which layer it is
		layerClicked.visible = false
		if clickingMiddle < previewMiddlePanel.length - 1
			clickingMiddle++
			previewMiddlePanel[clickingMiddle].visible = true
		else
			previewMiddlePanel[0].visible = true
			clickingMiddle = 0
clickingLeft = 0
for layer, index in previewLeftPanel
	if index > 0
		layer.visible= false
	layer.on Events.Click, (event, layerClicked)->
		# Find out which layer it is
		layerClicked.visible = false
		if clickingLeft < previewLeftPanel.length - 1
			clickingLeft++
			previewLeftPanel[clickingLeft].visible = true
		else
			previewLeftPanel[0].visible = true
			clickingLeft = 0


