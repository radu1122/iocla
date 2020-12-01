
section .data
    delim db " ", 0

section .bss
    root resd 1

section .text

extern evaluate_ast
global create_tree
global iocla_atoi

iocla_atoi:
    ; TODO
    mov eax, dword [esp + 8]
    xor ecx, ecx
    movzx ebx, byte [eax]
    cmp bl, 45
    jne start_iteration
    mov ecx, 1
    xor edx, edx

start_iteration:
    ; mul edx, 10
    lea edx, [edx + edx * 4]
    add edx, edx
    movzx ebx, byte [eax + ecx]

    cmp bl, 10 ; check if \0
    jne final_atoi
    add edx, ebx
    sub edx, 48
    
    add ecx, 1
    jmp start_iteration

final_atoi:
    mov eax, dword [esp + 8]
    movzx ebx, byte [eax]
    cmp bl, 45
    jne return_atoi
    neg edx
    jmp return_atoi

return_atoi:
    mov eax, edx
    pop ebx
    ret


create_tree:
    ; TODO
    enter 0, 0
    xor eax, eax
    leave
    ret
