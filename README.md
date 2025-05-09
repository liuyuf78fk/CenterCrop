# CenterCrop

**CenterCrop** is a lightweight, zero-dependency image cropping tool for Windows 10/11 that crops images to a specified aspect ratio **without resizing**. It keeps the central portion of the image and evenly trims the excess from all sides when necessary.

This tool uses a simple `.bat` file to gather user input and a PowerShell script (`.ps1`) to process the image, leveraging only built-in Windows components (`System.Drawing`).

---

## Features

- **Center-based cropping**: Always crops symmetrically around the center of the image.
- **Aspect-ratio preservation**: User-defined target width and height are used to calculate cropping ratio, not final image resolution.
- **Smart side-trimming**: Trims the longer side(s) while keeping the image’s most important central area.
- **No external dependencies**: Fully based on native PowerShell and .NET; no need to install Python, ImageMagick, or any third-party tools.
- **Auto-named output**: Output file includes timestamp and original filename to avoid overwriting.
- **Simple execution**: Works by double-clicking the `.bat` file — no command-line skills required.

---

##  How It Works

1. You run `CenterCrop.bat`.
2. It asks you to input:
   - Image file name (in current folder)
   - Target width (e.g., 1800)
   - Target height (e.g., 1600)
3. The `.bat` script invokes `CenterCrop.ps1`, passing these values as arguments.
4. The PowerShell script:
   - Loads the original image using `System.Drawing.Image`.
   - Compares the source and target aspect ratios.
   - Calculates the largest centered rectangle matching the target ratio.
   - Crops the original image to that rectangle.
   - Saves the cropped image with a name like `CenterCrop-Output-<original-name>-<timestamp>.jpg`.

**Note**: The output resolution is not forced to match the input width/height — it preserves maximum quality by only cropping, not resizing.

---

## Example

If you input:
Image: landscape.jpg
Target width: 1800
Target height: 1600

- If `landscape.jpg` is 4000×3000 (4:3), and your target is 1800×1600 (9:8),
- The script will calculate the closest centered rectangle with a 9:8 ratio.
- Then it will **evenly trim** the necessary pixels from both left/right **or** top/bottom (depending on source shape).
- Resulting in a cropped image with the same quality, focused on the center.

---

## Getting Started

1. Download both `CenterCrop.bat` and `CenterCrop.ps1`.
2. Place them in the same folder as your image(s).
3. Double-click `CenterCrop.bat`.
4. Follow the prompts and find the output file in the same folder.

---

