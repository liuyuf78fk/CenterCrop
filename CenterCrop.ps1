param (
    [string]$InputFile,
    [int]$TargetWidth = 800,
    [int]$TargetHeight = 600
)

if (-not (Test-Path $InputFile)) {
    Write-Host "Error: File '$InputFile' not found."
    exit
}

Add-Type -AssemblyName System.Drawing

# Load source image
$image = [System.Drawing.Image]::FromFile($InputFile)
$srcWidth = $image.Width
$srcHeight = $image.Height
$srcAspect = $srcWidth / $srcHeight
$targetAspect = $TargetWidth / $TargetHeight

# Calculate crop area (centered)
if ($srcAspect -gt $targetAspect) {
    # Crop left and right
    $cropHeight = $srcHeight
    $cropWidth = [int]($cropHeight * $targetAspect)
    $cropX = [int](($srcWidth - $cropWidth) / 2)
    $cropY = 0
} else {
    # Crop top and bottom
    $cropWidth = $srcWidth
    $cropHeight = [int]($cropWidth / $targetAspect)
    $cropX = 0
    $cropY = [int](($srcHeight - $cropHeight) / 2)
}

$cropRect = New-Object System.Drawing.Rectangle $cropX, $cropY, $cropWidth, $cropHeight
$cropped = $image.Clone($cropRect, $image.PixelFormat)

# Output filename with timestamp
$baseName = [System.IO.Path]::GetFileNameWithoutExtension($InputFile)
$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$outputFile = "CenterCrop-Output-$baseName-$timestamp.jpg"

# Save output image
$cropped.Save($outputFile, [System.Drawing.Imaging.ImageFormat]::Jpeg)

$image.Dispose()
$cropped.Dispose()

Write-Host "Crop completed. Output file: $outputFile"
