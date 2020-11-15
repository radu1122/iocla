%include "io.mac"

section .text
    global bin_to_hex
    extern printf

bin_to_hex:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; hexa_value
    mov     esi, [ebp + 12]     ; bin_sequence
    mov     ecx, [ebp + 16]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement bin to hex

init_loop_counter:
    mov eax, [ebp + 16] ; used to loop
    xor ebx, ebx
    mov edx, 0

start_string_iteration:
    mov esi, [ebp + 12]     ; bin_sequence
    movzx ecx, byte [esi + edx]
    mov esi, eax
    cmp cl, 0x30
    jne char_is_1
    jmp char_is_0


char_is_1:
    cmp esi, eax
    jne start_pow
    mov ecx, 1
    jmp start_pow

start_pow:
    sub esi, 1
    shl ecx, 1

    cmp esi, 1
    jne char_is_1
    jmp finish_pow

char_is_0:
    mov ecx, 0
    jmp finish_pow

finish_pow:
    add edx, 1
    sub eax, 1
    add ebx, ecx



end_loop:
    ; mov edx, [ebp + 8]      ; hexa_value
    ; mov byte [edx + eax], bl
    ; add eax, 1
    cmp eax, 0
    jne start_string_iteration


    add ebx, 1

    PRINTF32 `%x\n\x0`, ebx

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY