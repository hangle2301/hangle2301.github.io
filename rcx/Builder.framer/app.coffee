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

# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: "Segment Builder"
	author: "Hang Le"
	twitter: ""
	description: ""





#Prep file
industryRow = sketch.row_industry
makeInteractive(industryRow)

#Industry Row open and Close
#industryRow.onClick ->
	
