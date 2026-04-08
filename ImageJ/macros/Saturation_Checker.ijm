// Checks for saturation

macro "Saturation Checker"{
global_max = 0
image_depth = bitDepth()
upper = Math.pow(2, image_depth) - 1
lower = upper - 1
setThreshold(lower, upper, "red")
max_message_shown = 0

for(j = 1; j <= nSlices; j++){	
setSlice(j);
		Max = getValue("Max");
		if (Max > global_max) {global_max = Max;}

		if (Max > lower) {
			setThreshold(lower, upper, "red");
			if (max_message_shown == 0) {
			maxMessage();
			max_message_shown = 1;}
		}
	}
	
// Success:
if (max_message_shown == 0) {
	Dialog.createNonBlocking("Saturation Checker");  
	Dialog.addMessage("No problems. Max recorded value: " + global_max);
	Dialog.show();
}


// Maximum value is at end of bit depth:
function maxMessage() {
Dialog.createNonBlocking("Saturation Checker");  
			Dialog.addMessage("CAMERA OVEREXPOSED!\n \nMax value in stack: " + global_max + " \nImage depth: " + image_depth + " (0-" + upper + ")");
			Dialog.show();
}
}

