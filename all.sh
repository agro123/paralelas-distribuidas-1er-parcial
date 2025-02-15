#!/usr/bin/env bash
#
# Este script se encarga de invocar los tres programas que permiten la 
# conversion de un PNG a secuencia de pixeles, se procesan esos pixeles y
# posteriormente se convierte esa secuencia de pixeles a un archivo en formato
# PNG
#
# Autor: John Sanabria - john.sanabria@correounivalle.edu.co
# Fecha: 2024-08-22
#
# INPUT_PNG="image.png"
# TEMP_FILE="image.bin"
# python3 fromPNG2Bin.py ${INPUT_PNG}
# ./main ${TEMP_FILE}
# python3 fromBin2PNG.py ${TEMP_FILE}.new

IMAGE_DIR="./images"
for INPUT_PNG in ${IMAGE_DIR}/*.jpg; do
    echo "--------------------------------------------------------"
    echo "Procesando $INPUT_PNG..."
    # Obtener las dimensiones de la imagen usando el script getDimensions.py
    dimensions=$(python3 getDimensions.py ${INPUT_PNG})
    width=$(echo $dimensions | cut -d ' ' -f 1)
    height=$(echo $dimensions | cut -d ' ' -f 2)
    echo "Dimensiones de la imagen Width: $width, Height: $height"

    TEMP_FILE="${INPUT_PNG%.jpg}.bin"
    python3 fromPNG2Bin.py ${INPUT_PNG}
    ./main ${TEMP_FILE} $width $height
    python3 fromBin2PNG.py ${TEMP_FILE}.new $width $height #Entrego el width y el height

    echo "Procesamiento de $INPUT_PNG finalizado."
    echo "--------------------------------------------------------"
done