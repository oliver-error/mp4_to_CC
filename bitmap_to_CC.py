import os
from PIL import Image

CCcolorsRGB = [
    (240, 240, 240), (242, 178, 51), (229, 127, 216), (153, 178, 242), (222, 222, 108), 
    (127, 204, 25), (242, 178, 204), (76, 76, 76), (153, 153, 153), (76, 153, 178), 
    (178, 102, 229), (51, 102, 204), (127, 102, 76), (87, 166, 78), (204, 76, 76), (17, 17, 17)
]
file = ""

width, height = 164, 81
image = Image.open(r"C:\Users\tyler\Downloads\Screenshot 2026-07-22 094002.bmp")
image = image.convert("RGB")
image = image.resize((width, height), Image.Resampling.NEAREST)
file = str(width) + ", " + str(height) + " ["


repeatCounter = 0
lastColorIndex = -1
for x in range(image.width):
    for y in range(image.height):
        r, g, b = image.getpixel((x, y))
        # Find the closest color in colors CC
        closest_color_index = min(range(len(CCcolorsRGB)), key=lambda i: (CCcolorsRGB[i][0] - r) ** 2 + (CCcolorsRGB[i][1] - g) ** 2 + (CCcolorsRGB[i][2] - b) ** 2)
        image.putpixel((x, y), CCcolorsRGB[closest_color_index])
        if closest_color_index == lastColorIndex:
            repeatCounter += 1
        else:
            if lastColorIndex != -1:
                file += str(lastColorIndex) + ":" + str(repeatCounter) + ", "
            lastColorIndex = closest_color_index
            repeatCounter = 1

if lastColorIndex != -1:
    file += str(lastColorIndex) + ":" + str(repeatCounter)

file += "]"

output_path = r"C:\Users\tyler\Downloads\data.CCimg"

# Open the file and write the contents
with open(output_path, "w", encoding="utf-8") as f:
    f.write(file)