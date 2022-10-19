//CBattleship

macroName = "Battleship"
var nChambers = 20
var mChambers = 8

Dialog.createNonBlocking(macroName); 
	Dialog.addNumber("Number of chambers in a row", nChambers); 
	Dialog.show();
	nChambers = Dialog.getNumber();

for (i = 0, j=1; i<roiManager("count"); i++){
	roiManager("select", (i));
	if ((i+1) % nChambers == 0) { 
		colName = nChambers;
		newName = d2s(j,0) +","+d2s(colName, 0);
		roiManager("rename", newName)
		j++;}
	else{
		colName = ((i+1) % nChambers);
		newName = d2s(j,0) +","+d2s(colName, 0);
		roiManager("rename", newName);}
roiManager("UseNames", "true");
roiManager("Show All");
}