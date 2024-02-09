## ImageJ Macros

### Circle Pro Tool
_Creates an array of ROIs (Circles, rectangles, or lines) from user input_

* Automatically creates ROIs over chambers for our microfluidic devices. ROIs are renamed from the imageJ default to something more useful. 

* ROIs created from Circle Pro are used by other macros like IntDenCSV, Pet Detective


### Pet Detective Tool
_Phycoerythrin Tag (PET) Detective_

Automatic cell detection from micrographs:
> Classic Mode
> * Centers view area over an ROI and prompts if there is a cell.
> * Answers to this prompt are recorded into a .csv file 
> * Capable of moving back or forward through ROI set

> Max Mode
> * If the highest pixel intensity within a chamber exceeds 5000 of 65536 units* the chamber is assumed to contain a cell
> * Results are exported into a .csv file

>\*optimized for 800 ms exposure on SMZ 800

### IntDenCSV
_Takes integrated density measurements at every ROI on every slice and outputs to a csv file_

* Results are exported to a .csv file

* If the 16-bit camera is maxed out a warning will appear


### Cyclops
_Overlays a low opacity image over each slice of a stack_

### eifel_65
_makes ROIs blue_

### battleship
_Renames ROIs by row,col_

### moveit
_Moves ROIs_

## MATLAB
