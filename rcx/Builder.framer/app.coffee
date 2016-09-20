# Disable hints
Framer.Extras.Hints.disable()
Framer.Extras.Preloader.setLogo("https://radiusintel-wpengine.netdna-ssl.com/wp-content/themes/vate/src/serve/assets/images/common/radius-logo.svg")


# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: "Segment Builder"
	author: "Hang Le"
	twitter: ""
	description: ""
# Import file "builder-prototype-2"
sketch = Framer.Importer.load("imported/builder-prototype-2@1x")
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
scroll = ScrollComponent.wrap(sketch.Builder_Open)
scroll.width = Screen.width
scroll.height = Screen.height
scroll.mouseWheelEnabled = true
scroll.scrollHorizontal = false
sketch.Builder_Open.draggable.enabled = false

#Setting background color
topMenu = sketch.Builder_Open
topMenu.html="<div id='top-bg'></div><div id='bottom-line'></div>"

topBackground = topMenu.querySelectorAll("#top-bg")[0]
topBackground.style["background-color"] = "#2b84c6"
topBackground.style["width"] = "100%"
topBackground.style["height"] = "60px"

topLine = topMenu.querySelector('#bottom-line')
topLine.style["border-bottom"] = "1px solid #D9DEE2"
topLine.style["height"] = "77px"

pageContent = sketch.everything
pageContent.x = Align.center()
#Prep file
industryRowClosed = sketch.row_prod_tech
industryRowOpen = sketch.row_tech_open
doneButton = sketch.Button_Done
bottomHalf = sketch.moveDown
#industryRowOpen.visible = false
industryRowOpen.opacity = 0
bottomHalf.closeY = bottomHalf.y
bottomHalf.openY = bottomHalf.y + industryRowOpen.height - 20
bottomHalf.y = bottomHalf.closeY

makeInteractive(industryRowClosed)
makeInteractive(doneButton)

#Industry Row open and Close
industryRowClosed.onClick ->
	#industryRowOpen.visible = true
	industryRowClosed.ignoreEvents = true
	bottomHalf.animate
		properties: 
			y: bottomHalf.openY
		curve: "spring"
		time: 1	
	industryRowOpen.animate
		properties: 
			opacity: 1
		curve: "linear"
		time: 0.25
	industryRowClosed.animate
		properties: 
			opacity: 0
		curve: "linear"
		time: 0.25
	
doneButton.onClick ->		
	industryRowClosed.ignoreEvents = false
	bottomHalf.animate
		properties: 
			y: bottomHalf.closeY
		curve: "spring"
		time: 1	
		delay: 0.25
	industryRowOpen.animate
		properties: 
			opacity: 0
		curve: "linear"
		time: 0.25
	industryRowClosed.animate
		properties: 
			opacity: 1
		curve: "linear"
		time: 0.25

# SAVE BUTTON
saveButtonOn = sketch.button_save_on
saveButtonOff = sketch.button_save_off
makeInteractive(saveButtonOn)
saveButtonOff.opacity = 0

saveButtonOn.onClick ->
	#Go to segment single
	window.location.href = 'https://hangle2301.github.io/rcx/California-Healthcare.framer/'	
# NAMING
textLayer = sketch.input_on
baseTextLayer = sketch.input_off
textLayer.html = "<input id='segmentName' name='segmentName' type='text' value=''>"
textInput = textLayer.querySelector("#segmentName")
#textInput.style["border"] = "1px solid #d9dee2"
textInput.style["background-color"] = "rgba(255,255,255,0)"
textInput.style["border-radius"] = "3px"
textInput.style["padding"] = "10px"
textInput.style["font"] = "Apex New"
textInput.style["font-size"] = "14px"
textInput.style["color"] = "#303b3e"
textInput.style["width"] = "470px"
textLayer.opacity = 0

textLayer.onClick ->
	textLayer.opacity = 1
	
# BELL & WHISTLES
industryRowClosed.onMouseOver ->
	#some fancy animation