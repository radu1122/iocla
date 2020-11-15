%include "io.mac"

section .text
    global my_strstr
    extern printf

my_strstr:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edi, [ebp + 8]      ; substr_index
    mov     esi, [ebp + 12]     ; haystack
    mov     ebx, [ebp + 16]     ; needle
    mov     ecx, [ebp + 20]     ; haystack_len
    mov     edx, [ebp + 24]     ; needle_len
    ;; DO NOT MODIFY

    ;; TO DO: Implement my_strstr

    mov edi, -1
    mov eax, 0 ; used to loop

init_loop_counter:
    mov dl, byte [ebx]
    cmp dl, byte [esi + eax] ; if needle[0] == haystack[i]
    jne end_loop

    ; if true
    mov edi, eax
    add eax, 1
    mov edx, 1


start_substr_iteration:

    cmp edx, [ebp + 24]
    jne if_substr_iteration
    jmp after_loop

    cmp edx, [ebp + 20]
    jne if_substr_iteration
    jmp final_if_substr

if_substr_iteration:
    movzx ecx, byte [ebx + edx]
    cmp byte [esi + eax], cl
    jne final_if_substr
    add eax, 1
    add edx, 1
    jmp start_substr_iteration

final_if_substr:
    mov eax, edi
    mov edi, -1
    jmp end_loop


end_loop:
    add eax, 1
    cmp [ebp + 20], eax 
    jne init_loop_counter


after_loop:
    cmp edi, -1
    je not_found_fn
    jmp finish

not_found_fn:
    mov ecx, [ebp + 20]     ; haystack_len
    mov edi, ecx
    add edi, 1
    jmp finish

finish:
    mov eax, edi
    mov edi, [ebp + 8]      ; substr_index
    mov [edi], eax
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
