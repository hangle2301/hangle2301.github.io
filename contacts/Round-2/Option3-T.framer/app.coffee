# Import file "Contacts-Prototype-R2-O3-T"
sketch = Framer.Importer.load("imported/Contacts-Prototype-R2-O3-T@1x")

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

# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Hang Le"
	twitter: ""
	description: ""


#Company by default
switcher = sketch.switcher
sketch.location1.children[1].opacity = 0
sketch.company.opacity = 1
sketch.location.opacity = 0
switcher.opacity = 0

# Clicking 
clickLocation = sketch.location1
clickCompany = sketch.company1
makeInteractive(clickLocation)
makeInteractive(clickCompany)
clickLocation.onClick ->
	sketch.company.opacity = 0
	sketch.location.opacity = 1
	sketch.company1.children[1].opacity = 0
	sketch.location1.children[1].opacity = 1
	switcher.opacity = 0
clickCompany.onClick ->
	sketch.company.opacity = 1
	sketch.location.opacity = 0
	sketch.company1.children[1].opacity = 1
	sketch.location1.children[1].opacity = 0	
	switcher.opacity = 0

# Showing modal
titleCompany = sketch.title
titleLocation = sketch.title1
makeInteractive(titleCompany)
#makeInteractive(titleLocation)
titleCompany.onClick ->
	if(switcher.opacity == 0)
		switcher.opacity = 1
	else
		switcher.opacity = 0
#titleLocation.onClick ->
#	switcher.opacity = 1

# Next bt click
makeInteractive(sketch.nextBt)
sketch.nextBt.onClick ->
	window.location.href = 'https://hangle2301.github.io/contacts/Builder1-T.framer/'		






