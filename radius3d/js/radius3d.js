
/* Hang Writing for Radius Hackathon */
var stats;
var rotate = true;
var camera, controls, scene, renderer, raycaster,target;
var mouse = new THREE.Vector2(), INTERSECTED;
var realMouseX, realMouseY;
var jsonurl = "data/insightsresponse.json";
var font;
var intersectables = [];
var normalColor = 0x0262B2;
var hoverColor = 0x01FFFF;
var textColor = 0x0A3D58;
var darkColor = 0x0262B2;
var spacingBlobs = 135;
var originalTime;

function init() {

	scene = new THREE.Scene();
	scene.fog = new THREE.FogExp2( 0xcccccc, 0.002 );
	renderer = new THREE.WebGLRenderer();
	renderer.setClearColor(scene.fog.color );
	renderer.setPixelRatio(window.devicePixelRatio);
	renderer.setSize(window.innerWidth, window.innerHeight);

	var container = document.getElementById( 'container' );
	container.appendChild( renderer.domElement );

	camera = new THREE.PerspectiveCamera(60, window.innerWidth / window.innerHeight, 1, 1000 );
	camera.position.z = 200;
	target = new THREE.Vector3( 0, 0, 0);

	controls = new THREE.TrackballControls( camera );
	controls.rotateSpeed = 1.0;
	controls.zoomSpeed = 1.2;
	controls.panSpeed = 0.8;
	controls.noZoom = false;
	controls.noPan = false;
	controls.staticMoving = true;
	controls.dynamicDampingFactor = 0.3;
	
	// lights
	light = new THREE.DirectionalLight( 0xA7A7A7 );
	light.position.set( 1, 1, 1 );
	scene.add( light );

	//left light
	light = new THREE.DirectionalLight( 0x2B84C6 );
	light.position.set( -1, -1, -1 );
	scene.add( light );

	light = new THREE.AmbientLight( 0x2E2E2E );
	scene.add( light );

	//
	raycaster = new THREE.Raycaster();	
	stats = new Stats();
	
	//container.appendChild(stats.dom);

	window.addEventListener( 'resize', onWindowResize, false );
	document.addEventListener( 'mousemove', onDocumentMouseMove, false );
	
	//Load font & Generate Json for Objects on scene
	var loader = new THREE.FontLoader();
	loader.load( 'fonts/' + 'helvetiker_regular.typeface.js', function ( response ) {
		font = response;
		getJson();
	});

	originalTime = Date.now();
}

// GENERATING BLOBS BASED ON JSON
function generateBlobs(returnJson){
	console.log(returnJson);	
	var index = 0;
	//Creating Groups	
	for (var grouping in returnJson){
		index++;
		console.log("Generating group " + grouping + " length " + returnJson[grouping].length);
		//Creating text field for Title
		var posX = (Math.random() - 0.5) * 750;
		var posY = (Math.random() - 0.5) * 750;
		var posZ = (Math.random() - 0.5) * (Math.round(index/4)) * 100;

		var textMesh = generateText(grouping, posX, posY, posZ);
		scene.add(textMesh);	
		//Creating blobs in each Title Group
		for (var i=0; i<returnJson[grouping].length; i++) {
				var numberBase = 20;
				/*if (returnJson[grouping][i]['won'] != 0)
					var numberBase = returnJson[grouping][i]['won']/returnJson[grouping][i]['new'];
				console.log(numberBase)*/
				var radius = (Math.random() - 0.2) * 20;
				var mesh = new THREE.Mesh( new THREE.IcosahedronGeometry(radius,1), 
					new THREE.MeshPhongMaterial( {
						color: normalColor,
						emissive: 0x072534,
						side: THREE.DoubleSide,
						shading: THREE.FlatShading
					} )
				);

				mesh.position.x = (Math.random() * 2 * spacingBlobs) + posX - spacingBlobs;
				mesh.position.y = (Math.random() * 2 * spacingBlobs) + posY - spacingBlobs;
				mesh.position.z = (Math.random() * spacingBlobs) + posZ - 1/2*spacingBlobs;
				mesh.associatedData = returnJson[grouping][i];
				mesh.added = false;
				
				mesh.updateMatrix();
				mesh.matrixAutoUpdate = false;
				scene.add(mesh);
				intersectables.push(mesh);
		}
		
	}

}
function getJson(){
	console.log("Getting Json");
	//Getting Json file (local)
	var request = $.ajax({
					url: jsonurl,
					crossDomain: true,
				});
	request.done(function(returnJson){
		generateBlobs(returnJson.payload);
	}) //end request done
}

// GENERATING 3D TEXT
function generateText(textValue, posX, posY, posZ){
	textGeo = new THREE.TextGeometry( textValue, {
					font: font,
					size: 10,
					height: 1,
					curveSegments: 4,
					bevelThickness: 1,
					bevelSize: 1.5,
					bevelEnabled: false,
					material: 0,
					extrudeMaterial: 1
				});
	var material = new THREE.MultiMaterial( [
					new THREE.MeshPhongMaterial( { color: textColor, shading: THREE.FlatShading } ), // front
					new THREE.MeshPhongMaterial( { color: darkColor, shading: THREE.SmoothShading } ) // side
				] );
	textGeo.computeBoundingBox();
	textGeo.computeVertexNormals();
	var textMesh1 = new THREE.Mesh( textGeo, material );

	textMesh1.position.x = posX;
	textMesh1.position.y = posY;
	textMesh1.position.z = posZ;
	textMesh1.rotation.x = 0;
	textMesh1.rotation.y = Math.PI * 2;
	return textMesh1;
}


function onWindowResize() {
	camera.aspect = window.innerWidth / window.innerHeight;
	camera.updateProjectionMatrix();
	renderer.setSize( window.innerWidth, window.innerHeight );
}

function animate(){
	requestAnimationFrame( animate );
	controls.update(); // required if controls.enableDamping = true, or if controls.autoRotate = true
	stats.update();
	render();

}

function onDocumentMouseMove( event ) {
	event.preventDefault();
	mouse.x = ( event.clientX / window.innerWidth ) * 2 - 1;
	mouse.y = - ( event.clientY / window.innerHeight ) * 2 + 1;
	realMouseX = event.clientX;
	realMouseY = event.clientY;
}


function render() {
	//Rotating Camera
	if (rotate){
		originalTime++;
		time = originalTime * 0.00055;
		camera.position.x = Math.cos(time) * 400;
		//camera.position.z = Math.sin(time) * 500;
		camera.position.y = Math.sin(time / 1.4) * 100;
		camera.lookAt(target);
	}
	camera.updateMatrixWorld();
	//INTERACTIVE
	// find intersections
	raycaster.setFromCamera(mouse,camera );
	var intersects = raycaster.intersectObjects(intersectables);
	if ( intersects.length > 0 ) {
		if ( INTERSECTED != intersects[0].object ) {
			if (INTERSECTED) 
				INTERSECTED.material.color.setHex( INTERSECTED.currentHex );
			else{
				INTERSECTED = intersects[0].object;
				INTERSECTED.currentHex = INTERSECTED.material.color.getHex();
				INTERSECTED.material.color.setHex(hoverColor);
				displayHover(INTERSECTED);
				document.addEventListener( 'click', addSignal, false );
			}
		}
	} else {
		if (INTERSECTED){
			if (!INTERSECTED.added)
				INTERSECTED.material.color.setHex( INTERSECTED.currentHex );
			removeHover(INTERSECTED);
		}
		INTERSECTED = null;
	}
	renderer.render( scene, camera );
}

var animating;
/* INTERACTION ON TOP OF SCENE */
function displayHover(intersectedObject){
		rotate = false;
		//Place hover at the position
		$(".hoverPanel").stop().animate({opacity: 1},200, function(){});
		$(".hoverPanel").css({left: realMouseX + "px", top: realMouseY + "px"});
		//Displaying data
		var displayName = "";
		if (intersectedObject.associatedData['name'])
			displayName = intersectedObject.associatedData['name']
		else
			displayName = intersectedObject.associatedData['type'] + " : " + intersectedObject.associatedData['value']
		$(".hoverPanel h3").html(displayName);
		$(".hoverPanel .newRecords").html(withSuffix(intersectedObject.associatedData['new']));
		$(".hoverPanel .openRecords").html(withSuffix(intersectedObject.associatedData['open']));
		$(".hoverPanel .wonRecords").html(withSuffix(intersectedObject.associatedData['won']));
		$(".hoverPanel .lossRecords").html(withSuffix(intersectedObject.associatedData['lost']));
}
var signalCount = 0;
var totalNew = 0, totalOpen = 0, totalWon = 0, totalLoss = 0;
function addSignal(){
	//Adding signal
	var intersectedObject = INTERSECTED;
	INTERSECTED.added = true;
	if (intersectedObject){
		//If this is the first one, slide out the panel
		if (signalCount == 0)
			$('.sidebar').stop().animate({right:"0px"}, 250, function(){});
		//Combining numbers
		totalNew += intersectedObject.associatedData['new'];
		totalOpen += intersectedObject.associatedData['open'];
		totalWon += intersectedObject.associatedData['won'];
		totalLoss += intersectedObject.associatedData['lost'];

		//Displaying Numbers
		$(".combinedNewRecords").html(withSuffix(totalNew));
		$(".combinedOpenRecords").html(withSuffix(totalOpen));
		$(".combinedWonRecords").html(withSuffix(totalWon));
		$(".combinedLossRecords").html(withSuffix(totalLoss));
		//Display Signals
		signalCount++;
		$('.sidebar-count').html("Selected Signals (" + signalCount + ")");
		var displayName = "";
		if (intersectedObject.associatedData['name'])
			displayName = intersectedObject.associatedData['name']
		else
			displayName = intersectedObject.associatedData['value']
		$('.sidebar-signals').append("<p>"+ intersectedObject.associatedData['type'] + "</p><h2>" + displayName + "</h2>" + "<img class='remove' src='imgs/remove.svg'>");
	}
	document.removeEventListener('click', addSignal);
}
function removeHover(intersectedObject){
	rotate = true;
	document.removeEventListener('click', addSignal);
 	$(".hoverPanel").stop().animate({opacity: 0}, 200, function(){});
}

/* RIGHT PANEL */
function withSuffix(value) {
    var newValue = value;
    if (value >= 1000) {
        var suffixes = ["", "K", "M", "B","T"];
        var suffixNum = Math.floor( (""+value).length/3 );
        var shortValue = '';
        for (var precision = 2; precision >= 1; precision--) {
            shortValue = parseFloat( (suffixNum != 0 ? (value / Math.pow(1000,suffixNum) ) : value).toPrecision(precision));
            var dotLessShortValue = (shortValue + '').replace(/[^a-zA-Z 0-9]+/g,'');
            if (dotLessShortValue.length <= 2) { break; }
        }
        if (shortValue % 1 != 0)  shortNum = shortValue.toFixed(1);
        newValue = shortValue+suffixes[suffixNum];
    }
    return newValue;
}
function createSegment(){
	$('.modal-bg').stop().animate({top:"50%"}, 250, function(){});
}
function restart(){
	window.location.reload();
}
function cancelSegment(){
	//Slide right panel in
	$('.sidebar').stop().animate({right:"-400px"}, 250, function(){});
	//Remove all blobs added
	console.log(intersectables.length);
	for (var i=0; i <intersectables.length; i++){
		blob = intersectables[i];
		blob.added = false;
		blob.material.color.setHex(normalColor);
	}
	//Reset numbers of right panel
	totalNew = 0;
	totalOpen = 0;
	totalWon = 0;
	totalLoss = 0;
	signalCount = 0;
	$('.sidebar-signals').html("<h1 class='sidebar-count'>Selected Signals (0)</h1>");
	$(".combinedNewRecords").html(withSuffix(totalNew));
	$(".combinedOpenRecords").html(withSuffix(totalOpen));
	$(".combinedWonRecords").html(withSuffix(totalWon));
	$(".combinedLossRecords").html(withSuffix(totalLoss));
}















