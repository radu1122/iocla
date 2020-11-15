%include "io.mac"

section .text
    global vigenere
    extern printf

vigenere:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     ecx, [ebp + 16]     ; plaintext_len
    mov     edi, [ebp + 20]     ; key
    mov     ebx, [ebp + 24]     ; key_len
    ;; DO NOT MODIFY

    ;; TODO: Implement the Vigenere cipher
init_loop_counter:
    xor ecx, ecx
    mov eax, 0 ; used to loop
    mov ecx, 0 ; used to loop key 

start_string_iteration:
    cmp ecx, [ebp + 24]
    jne loop_real_start
    mov ecx, 0
    jmp loop_real_start
    
loop_real_start:

    movzx ebx, byte [esi + eax]
    
    cmp ebx, 64 ; Bigger than Letter 'A'
    jle small_letters
    cmp ebx, 90 ; Smaller than Letter 'Z'
    jg small_letters

    sub bx, 65
    add bl, byte [edi + ecx] ; aici adaug noul meu cod 
    add ecx, 1
    cmp bl, 90

    jle end_loop
    sub ebx, 26

    jmp end_loop

small_letters:
    cmp ebx, 96  ; bigger than letter 'a'
    jle end_loop
    cmp ebx, 122 ; smaller than letter 'z'
    jg end_loop

    sub bx, 65
    add bl, byte [edi + ecx] ; aici adaug noul meu cod 
    add ecx, 1
    cmp bx, 122


    jle end_loop
    sub ebx, 26


    jmp end_loop

end_loop:

    mov byte [edx + eax], bl
    add eax, 1
    cmp [ebp + 16], eax 
    jne start_string_iteration
    
    ;; DO NOT MODIFY

    popa
    leave
    ret
    ;; DO NOT MODIFY