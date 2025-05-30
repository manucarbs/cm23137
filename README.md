# ✅ Portafolio

Este repositorio contiene código en lenguaje ensamblador (.asm) que realiza operaciones como: Resta de tres enteros (16 bits), Multiplicación (8 bits) y División (32 bits).

## 📁 Estructura del proyecto

- Ejercicio 1  
    resta.asm
    resta
    resta.o
---
- Ejercicio 2  
    multiplicacion.asm
    multiplicacion
    multiplicacion.o
---
- Ejercicio 3  
    division.asm
    division
    division.o
---

## 🧠 Uso

Para compilar un archivo `.asm`, usar los comandos:

```bash
nasm -f elf64 -o archivo.o archivo.asm
ld -o archivo archivo.o
./archivo