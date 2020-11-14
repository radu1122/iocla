%include "io.mac"

section .text
    global otp
    extern printf

otp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement the One Time Pad cipher

    mov eax, 0 ; used to loop
start_string_iteration:
    movzx ebx, byte [esi + eax]
    xor bl, BYTE [edi + eax]
    mov BYTE [edx + eax], bl

    add eax, 1
    cmp ecx, eax 
    jne start_string_iteration

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY