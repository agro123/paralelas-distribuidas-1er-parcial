# Procesamiento de imágenes

# Resultados de Ejecución

Este archivo muestra los resultados de ejecución de un programa en dos modos: secuencial y paralelizado con OpenMP. Se detallan los tiempos de ejecución y las métricas de rendimiento como el speedup y la eficiencia.

---

## Ejecución Secuencial

| Exec | Tiempo (s) |
|------|------------|
| 1    | 40.28      |
| 2    | 31.83      |
| 3    | 40.69      |
| 4    | 36.48      |
| 5    | 39.61      |

**Tiempo de ejecución promedio**: 38.79 s

---

## Ejecución Paralelizada con OpenMP

### 12 Hilos

| Exec | Tiempo (s) |
|------|------------|
| 1    | 25.90      |
| 2    | 38.17      |
| 3    | 54.61      |
| 4    | 35.90      |
| 5    | 38.60      |

**Tiempo de ejecución promedio**: 37.56 s  
**Speedup**: 1.033  
**Eficiencia**: 0.086 = 8.6%

### 24 Hilos

| Exec | Tiempo (s) |
|------|------------|
| 1    | 25.87      |
| 2    | 33.10      |
| 3    | 48.65      |
| 4    | 39.89      |
| 5    | 41.74      |

**Tiempo de ejecución promedio**: 38.24 s  
**Speedup**: 1.014  
**Eficiencia**: 0.0422 = 4.22%

---

## Conclusiones y Comentarios

- Agregué un archivo llamado getDimension.py que obtiene las dimensiones de la imagen, para después ser almacenadas en una variable de bash y por último ser entregadas como parámetros a los procesos main y fromBin2PNG.py. Esto con el objetivo de que se procesen correctamente imágenes de cualquier dimensión y no solo de 1024 * 1024.

```python
# getDimension.py
import sys
from PIL import Image

if len(sys.argv) != 2:
    print("Uso: Obtener dimensiones de la imagen")
    sys.exit(1)

image_file = sys.argv[1]
with Image.open(image_file) as img:
    width, height = img.size

print(f"{width} {height}")
```
 - Al implementar openMP se utilizó la directiva “#pragma omp parallel for” en los ciclos de las funciones “aplicaFiltro” y “calcularSumaPixeles”. Adicionalmente para “aplicaFiltro” se utilizó el método “schedule(dynamic)” para balancear la carga en cada hilo y para “calcularSumaPixeles” el método “reduction(+:suma)” para evitar competencia al modificar la variable compartida, fork-join.
 - Para la implementación con 12 hilos, el total disponible de la máquina, su speed up refleja una mejora muy pequeña con respecto a la versión secuencial de siendo un  3.3% más rápida y en la eficiencia también se observa un valor muy pequeño por lo que la optimización del algoritmo tiene un margen mucho mayor.
 - Para la implementación con 24 hilos, el doble del total disponible de la máquina, su speed up refleja una mejora respecto al secuencial, pero un menor número a la versión con 12 hilos, ya que crear más hilos de los disponibles no garantiza un mayor rendimiento, hay una mayor competencia por los recursos y eso se ve reflejado en su eficiencia. 



# paralelas-distribuidas-1er-parcial
