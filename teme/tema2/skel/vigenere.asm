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

init_loop_generate_key:
    mov edx, ebx ; used to loop
    mov ebx, 0 ; used to loop
start_generate_key_loop:
    cmp ebx, [ebp + 24]
    jne end_loop
    mov ebx, 0
    jmp end_loop

end_loop:
    movzx eax, BYTE [edi + ebx]
    mov BYTE [edi + edx], al
    add edx, 1
    add ebx, 1
    cmp ecx, edx 
    jne start_generate_key_loop

    PRINTF32 "%s\n", edi
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY