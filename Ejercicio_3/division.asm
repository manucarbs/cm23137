section .data
    newline db 10              

section .bss
    result resb 20             ; Espacio donde vamos a guardar el número convertido a texto

section .text
    global _start

_start:
    mov eax, 50                ; El número que vamos a dividir 
    mov ebx, 5                 ; El número por el que lo dividimos 

    xor edx, edx               ; Hay que limpiar EDX antes de dividir
    div ebx                    ; EAX / EBX → cociente en EAX, resto en EDX

    movsx rsi, eax             ; Pasamos el resultado a RSI
    mov rdi, result            ; RDI apunta al buffer donde guardamos el texto
    call print_number          ; Mandamos a imprimir el número

    mov rax, 1                 ; syscall write
    mov rdi, 1                 ; salida
    mov rsi, newline
    mov rdx, 1
    syscall

    ; Cierre
    mov rax, 60                ; syscall exit
    xor rdi, rdi               ; Código de salida 0
    syscall

print_number:
    push rbx                   ; Guardamos lo que estamos usando
    push rcx
    push rdx
    push rsi
    push rdi

    mov rax, rsi               ; Copiamos el número a RAX para trabajarlo
    mov rcx, 0                 ; Contador de dígitos
    mov rbx, 10                ; Vamos a dividir entre 10 (para convertir a texto)
    mov r8, rdi                ; Guardamos el inicio del buffer original

    cmp rax, 0
    jge .convert
    neg rax                    ; Si es negativo, lo pasamos a positivo...
    mov byte [rdi], '-'        ; anotamos el signo menos
    inc rdi                    ; Avanzamos en el buffer

.convert:
    cmp rax, 0
    jne .loop
    mov byte [rdi], '0'        ; Si es cero, imprimimos '0'
    inc rdi
    jmp .print

.loop:
    xor rdx, rdx
    div rbx                    ; Dividimos entre 10
    add dl, '0'                ; Convertimos el número a caracter ASCII
    push rdx                   ; Guardamos el dígito
    inc rcx                    ; Contamos cuántos llevamos
    test rax, rax              ; ¿Ya terminamos?
    jnz .loop                  ; Si no, seguimos dividiendo

.print:
    cmp rcx, 0
    je .done                   ; Si no había dígitos, saltamos todo

.pop_loop:
    pop rax                    ; Sacamos los dígitos en orden
    mov [rdi], al
    inc rdi
    dec rcx
    jnz .pop_loop

.done:
    mov rdx, rdi
    sub rdx, r8                ; Calculamos cuántos bytes vamos a imprimir

    mov rax, 1
    mov rdi, 1
    mov rsi, r8                ; rsi apunta al principio del buffer
    syscall                    ; Mandamos el texto a la pantalla

    pop rdi
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    ret 
