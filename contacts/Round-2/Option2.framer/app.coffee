# Import file "Contacts-Prototype-R2-O2"
sketch = Framer.Importer.load("imported/Contacts-Prototype-R2-O2@1x")
# Import file "Contacts-Prototype-R2-O2"

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
sketch.locations.children[1].opacity = 0
sketch.contacts.children[1].opacity = 0
sketch.accountPanel.opacity = 1
sketch.locationPanel.opacity = 0
sketch.contactPanel.opacity = 0
switcher.opacity = 0

# Clicking 
clickLocation = sketch.locations
clickCompany = sketch.accounts
clickContact = sketch.contacts
makeInteractive(clickLocation)
makeInteractive(clickCompany)
makeInteractive(clickContact)

clickLocation.onClick ->
	sketch.accountPanel.opacity = 0
	sketch.contactPanel.opacity = 0
	sketch.locationPanel.opacity = 1
	
	clickCompany.children[1].opacity = 0
	clickContact.children[1].opacity = 0
	clickLocation.children[1].opacity = 1
	switcher.opacity = 0
clickCompany.onClick ->
	sketch.accountPanel.opacity = 1
	sketch.contactPanel.opacity = 0
	sketch.locationPanel.opacity = 0

	clickCompany.children[1].opacity = 1
	clickContact.children[1].opacity = 0
	clickLocation.children[1].opacity = 0
	switcher.opacity = 0
	
clickContact.onClick ->
	sketch.accountPanel.opacity = 0
	sketch.contactPanel.opacity = 1
	sketch.locationPanel.opacity = 0

	clickCompany.children[1].opacity = 0
	clickContact.children[1].opacity = 1
	clickLocation.children[1].opacity = 0
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



