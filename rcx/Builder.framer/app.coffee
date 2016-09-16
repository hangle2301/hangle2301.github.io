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

#Prep file
industryRowClosed = sketch.row_industry
industryRowOpen = sketch.row_industry_open
doneButton = sketch.Button_Done
bottomHalf = sketch.moveDown
#industryRowOpen.visible = false
industryRowOpen.opacity = 0
bottomHalf.closeY = bottomHalf.y
bottomHalf.openY = bottomHalf.y + industryRowOpen.height
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

	
	
# BELL & WHISTLES
industryRowClosed.onMouseOver ->
	#some fancy animation