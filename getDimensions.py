import sys
from PIL import Image

if len(sys.argv) != 2:
    print("Obtener dimensiones de la imagen")
    sys.exit(1)

image_file = sys.argv[1]
with Image.open(image_file) as img:
    width, height = img.size

print(f"{width} {height}")
