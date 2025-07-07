# 🔬 ImageJ Macros for Microfluidics & Cell Detection

A suite of **ImageJ macros** developed to streamline ROI creation, fluorescence quantification, and image-based cell detection in microfluidic devices.

---

## 🔵 Circle Pro Tool

**Purpose**: Quickly create arrays of ROIs (circles, rectangles, or lines) based on user input.

- Designed for use with microfluidic chamber images.
- Automatically positions ROIs over known chamber positions.
- Renames each ROI with meaningful labels instead of ImageJ's defaults.
- Used as a foundation by downstream macros like **IntDenCSV** and **Pet Detective**.

---

## 🐱 Pet Detective Tool

**PET** = *Phycoerythrin Tag*. This macro assists in semi-automated or fully automated cell detection within ROIs.

### 🔍 Classic Mode

- Cycles through ROIs, centers the view, and prompts the user:  
  _“Is there a cell present?”_
- User responses are recorded in a `.csv` file.
- Supports forward and backward navigation through the ROI set.

### ⚡ Max Mode

- Automatically checks if the maximum pixel intensity in a chamber exceeds a threshold.
- If intensity > `5000` (of 65536), the chamber is assumed to contain a cell.
- Optimized for: **800 ms exposure** on the **SMZ 800** microscope.
- Results are logged to a `.csv` file.

---

## 📊 IntDenCSV

**Purpose**: Extract integrated density values across slices and ROIs.

- Measures **integrated density** (sum of pixel values) at each ROI in every slice of a stack.
- Exports results to `.csv`.
- Warns the user if **16-bit saturation** is detected (camera maxed out).

---

## 👁 Cyclops

**Purpose**: Overlay a semi-transparent reference image over each slice of a stack.

- Useful for visual alignment or normalization across frames.

---

## 🔵 eiffel_65

- Makes all ROIs **blue**.
- Good for visual contrast or figure prep.

---

## 🅱 Battleship

- Renames ROIs based on **row and column** indexing.
- Useful for grid-based chamber layouts.

---

## ➡ moveit

- Moves all ROIs by a specified offset.

---

## 🧠 MATLAB Scripts

MATLAB scripts are here too for archival purposes. I wouldn't bother trying to work with them.

To the graduate student following in my footsteps: try python instead. 

:)

