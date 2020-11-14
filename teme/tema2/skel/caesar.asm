%include "io.mac"

section .text
    global caesar
    extern printf

caesar:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement the caesar cipher


start_testing_key:
    cmp edi, 26
    jle init_loop_counter
    sub edi, 26
    jmp start_testing_key

init_loop_counter:
    mov eax, 0 ; used to loop

start_string_iteration:
    movzx ebx, byte [esi + eax]
    
    cmp ebx, 64 ; Bigger than Letter 'A'
    jle small_letters
    cmp ebx, 90 ; Smaller than Letter 'Z'
    jg small_letters
    add ebx, edi
    cmp ebx, 90 ; Greater than letter 'Z'
    jle end_loop
    sub ebx, 26
    jmp end_loop

small_letters:
    cmp ebx, 96  ; bigger than letter 'a'
    jle end_loop
    cmp ebx, 122 ; smaller than letter 'z'
    jg end_loop
    add ebx, edi
    cmp ebx, 122 ; greater than 'z'
    jle end_loop
    sub ebx, 26
    jmp end_loop

end_loop:
    mov byte [edx + eax], bl
    add eax, 1
    loop start_string_iteration

    ; PRINTF32 "%s\n", edx

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY