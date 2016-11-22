# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Hang Le"
	twitter: ""
	description: ""


# Import file "Contacts-Prototype-R2-Opt2"
sketch = Framer.Importer.load("imported/Contacts-Prototype-R2-Opt2@1x")


# CURSOR CHANGE & SCROLLING
document.body.style.cursor = "auto"
Framer.Extras.Hints.disable()
Framer.Extras.Preloader.setLogo("https://radiusintel-wpengine.netdna-ssl.com/wp-content/themes/vate/src/serve/assets/images/common/radius-logo.svg")


#Make interactive
makeInteractive = (object) ->
	object.onMouseOver ->
		document.body.style.cursor = "pointer"
	object.onMouseOut ->
		document.body.style.cursor = "auto"

# Make scroll
# Include a Layer 
scroll = ScrollComponent.wrap(sketch.everything)
scroll.width = Screen.width
scroll.height = Screen.height
scroll.mouseWheelEnabled = true
sketch.everything.draggable.enabled = false

# Center all
pageContent = sketch.everything
pageContent.x = Align.center()
recordBreakdown = sketch.recordBreakdown
contactBreakdown = sketch.contactBreakdown

recordButton = sketch.records
contactButton = sketch.Contact
sketch.on.opacity = 0

makeInteractive(contactButton)
makeInteractive(recordButton)
contactBreakdown.opacity = 0
contactButton.onClick ->
	sketch.on1.opacity = 0
	sketch.off1.opacity = 1
	sketch.off.opacity = 0
	sketch.on.opacity = 1
	contactBreakdown.opacity = 1
	recordBreakdown.opacity= 0
recordButton.onClick ->
	sketch.on1.opacity = 1
	sketch.off1.opacity = 0
	sketch.off.opacity = 1
	sketch.on.opacity = 0
	contactBreakdown.opacity = 0
	recordBreakdown.opacity= 1
	

		
