# ✅ Portafolio

Este repositorio contiene código en lenguaje ensamblador (.asm) que realiza operaciones como: Resta de tres enteros (16 bits), Multiplicación (8 bits) y División (32 bits).

## 📁 Estructura del proyecto

- Ejercicio 1  
  - `resta.asm`  
  - `resta`  
  - `resta.o`  
---
- Ejercicio 2  
  - `multiplicacion.asm`  
  - `multiplicacion`  
  - `multiplicacion.o`  
---
- Ejercicio 3  
  - `division.asm`  
  - `division`  
  - `division.o`  
---

## 📝 Descripción

- **Ejercicio 1 – Resta**  
  Este programa realiza la operación de resta entre dos números. Toma dos valores como entrada, realiza la operación y muestra el resultado.
---
- **Ejercicio 2 – Multiplicación**  
  Implementa la multiplicación de dos números enteros utilizando sumas sucesivas. Es decir, se simula la operación sin usar instrucciones de multiplicación directa.
---
- **Ejercicio 3 – División**  
  Realiza la división entre dos números enteros empleando restas sucesivas. El programa determina cuántas veces se puede restar el divisor del dividendo, simulando así el proceso de división.
---

## 🧠 Uso

Para compilar un archivo `.asm`, usar los comandos:

```bash
nasm -f elf64 -o archivo.o archivo.asm
ld -o archivo archivo.o
./archivo