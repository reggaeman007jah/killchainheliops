loadimages[] = {
	"media\images\loadScreen1.jpg",
	"media\images\loadScreen2.jpg",
	"media\images\loadScreen3.jpg",
	"media\images\loadScreen4.jpg",
	"media\images\loadScreen5.jpg",
	"media\images\loadScreen6.jpg"
	"media\images\loadScreen7.jpg"
	"media\images\loadScreen8.jpg"
	"media\images\loadScreen9.jpg"
	"media\images\loadScreen10.jpg"
	"media\images\loadScreen11.jpg"
	"media\images\loadScreen12.jpg"
	"media\images\loadScreen13.jpg"
	"media\images\loadScreen14.jpg"
}; 
loadScreen = selectRandom (getArray (missionconfigfile >> "loadimages"));
loadScreen