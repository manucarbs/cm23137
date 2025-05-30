section .data
    newline db 10              

section .bss
    result resb 20             ; Espacio para guardar el número como texto

section .text
    global _start

_start:
    mov al, 5                  ; Primer número
    mov bl, 10                  ; Segundo número

    mul bl                     ; AL * BL = 25 → resultado en AX (16 bits)

    movsx rsi, ax              ; Pasamos AX (16 bits) a RSI (64 bits), conservando el signo
    mov rdi, result            ; RDI apunta al buffer donde se guarda el número como texto
    call print_number          ; Llama a la función para imprimir el número

    ; Imprimir un salto de línea
    mov rax, 1                 ; syscall write
    mov rdi, 1                 ; stdout
    mov rsi, newline           ; dirección del salto de línea
    mov rdx, 1                 ; tamaño: 1 byte
    syscall

    ; Salir del programa
    mov rax, 60                ; syscall exit
    xor rdi, rdi               ; código de salida: 0
    syscall

print_number:
    push rbx
    push rcx
    push rdx
    push rsi
    push rdi

    mov rax, rsi               ; Copiamos el número a RAX
    mov rcx, 0                 ; Contador de dígitos
    mov rbx, 10                ; Vamos a dividir entre 10 (decimal)
    mov r8, rdi                ; Guardamos inicio del buffer

    cmp rax, 0
    jge .convert               ; Si es positivo, seguimos normal
    neg rax                    ; Si es negativo, lo volvemos positivo
    mov byte [rdi], '-'        ; Escribimos el signo negativo
    inc rdi                    ; Avanzamos una posición en el buffer

.convert:
    cmp rax, 0
    jne .loop
    mov byte [rdi], '0'        ; Si el número es 0, escribimos "0"
    inc rdi
    jmp .print

.loop:
    xor rdx, rdx               ; Limpiamos RDX antes de dividir
    div rbx                    ; Dividimos RAX / 10
    add dl, '0'                ; Convertimos el dígito a carácter
    push rdx                   ; Guardamos en la pila (para imprimir luego en orden correcto)
    inc rcx                    ; Aumentamos el contador
    test rax, rax
    jnz .loop                  ; Repetimos si RAX no es 0

.print:
    cmp rcx, 0
    je .done

.pop_loop:
    pop rax
    mov [rdi], al              ; Sacamos cada dígito y lo ponemos en el buffer
    inc rdi
    dec rcx
    jnz .pop_loop

.done:
    mov rdx, rdi
    sub rdx, r8                ; Calculamos cuántos bytes vamos a imprimir

    ; Imprimimos el número
    mov rax, 1                 ; syscall write
    mov rdi, 1                 ; stdout
    mov rsi, r8                ; buffer con el número
    syscall

    ; Restauramos registros
    pop rdi
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    ret
