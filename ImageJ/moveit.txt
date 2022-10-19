macro "Move It [f9]" {
var x = 0
var y = 0
Dialog.createNonBlocking("We like to move it"); 
Dialog.addMessage("x increases towards the right");
Dialog.addMessage("y increases down");
Dialog.addNumber("move x: ", x); 
Dialog.addNumber("move y: ", y);
Dialog.show();
x= Dialog.getNumber();
y= Dialog.getNumber();
roiManager("translate", x, -y);
}
