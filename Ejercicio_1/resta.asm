section .data
    newline db 10          ; salto de línea (enter)

section .bss
    result resb 20         ; espacio para guardar el número en texto

section .text
    global _start

_start:
    mov ax, 25
    mov bx, 10
    mov cx, 10

    sub ax, bx             ; restamos 5 a 25
    sub ax, cx             ; restamos 10 al resultado anterior

    movsx rsi, ax          ; pasar el resultado a 64 bits, manteniendo el signo
    mov rdi, result        ; apuntamos al espacio para guardar el texto
    call print_number      ; llamar a la función que convierte y muestra el número

    ; ahora imprimimos el salto de línea
    mov rax, 1
    mov rdi, 1             ; salida estándar (pantalla)
    mov rsi, newline       ; dirección del salto de línea
    mov rdx, 1             ; tamaño 1 byte
    syscall

    ; salir del programa
    mov rax, 60
    xor rdi, rdi           ; código de salida 0
    syscall

print_number:
    push rbx
    push rcx
    push rdx
    push rsi
    push rdi

    mov rax, rsi           ; agarramos el número para trabajar con él
    mov rcx, 0             ; contador para los dígitos que vamos a sacar
    mov rbx, 10            ; divisor para ir sacando cada dígito
    mov r8, rdi            ; guardamos la dirección del buffer original

    cmp rax, 0
    jge .convert
    neg rax                ; si es negativo, lo hacemos positivo
    mov byte [rdi], '-'    ; y ponemos el signo menos en el buffer
    inc rdi                ; avanzamos el puntero para no pisar el signo

.convert:
    cmp rax, 0
    jne .loop
    mov byte [rdi], '0'    ; si el número es cero, ponemos '0'
    inc rdi
    jmp .print

.loop:
    xor rdx, rdx
    div rbx                ; dividimos para sacar el último dígito
    add dl, '0'            ; lo convertimos a su carácter ASCII
    push rdx               ; lo guardamos en la pila para imprimir después
    inc rcx                ; contamos un dígito
    test rax, rax
    jnz .loop              ; seguimos hasta que no queden más dígitos

.print:
    cmp rcx, 0
    je .done

.pop_loop:
    pop rax
    mov [rdi], al          ; escribimos el dígito en el buffer
    inc rdi                ; avanzamos al siguiente espacio
    dec rcx
    jnz .pop_loop          ; seguimos hasta acabar todos los dígitos

.done:
    mov rdx, rdi
    sub rdx, r8            ; calculamos la longitud total del texto

    mov rax, 1             ; syscall para escribir
    mov rdi, 1             ; salida estándar (pantalla)
    mov rsi, r8            ; dirección del buffer original
    syscall

    pop rdi
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    ret