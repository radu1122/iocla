
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

add:
        push    ebp
        push    edi
        push    esi
        push    ebx
        sub     esp, 12
        mov     edi, DWORD PTR [esp+32]
        mov     esi, DWORD PTR [esp+36]
.L9:
        movzx   edx, BYTE PTR [esi]
        cmp     dl, 32
        jne     .L2
        movzx   edx, BYTE PTR [esi+1]
        add     esi, 1
.L2:
        test    dl, dl
        je      .L3
        mov     ebp, DWORD PTR [edi]
        mov     ebx, 1
        test    ebp, ebp
        jne     .L5
        sub     esp, 12
        mov     ebx, 1
        push    12
        call    malloc
        mov     ebp, eax
        movzx   eax, BYTE PTR [esi+1]
        add     esp, 16
        sub     eax, 48
        cmp     al, 9
        jbe     .L7
.L6:
        sub     esp, 8
        push    ebx
        push    esi
        call    strndup
        mov     DWORD PTR [ebp+4], 0
        mov     DWORD PTR [ebp+0], eax
        add     esp, 16
        mov     DWORD PTR [ebp+8], 0
        mov     DWORD PTR [edi], ebp
        movzx   edx, BYTE PTR [esi]
        test    dl, dl
        jne     .L5
.L3:
        xor     eax, eax
.L1:
        add     esp, 12
        pop     ebx
        pop     esi
        pop     edi
        pop     ebp
        ret
.L7:
        add     ebx, 1
        movzx   eax, BYTE PTR [esi+ebx]
        lea     edx, [eax-48]
        cmp     dl, 9
        ja      .L6
        add     ebx, 1
        movzx   eax, BYTE PTR [esi+ebx]
        lea     edx, [eax-48]
        cmp     dl, 9
        jbe     .L7
        jmp     .L6
.L5:
        sub     edx, 48
        lea     eax, [esi+ebx]
        cmp     dl, 9
        jbe     .L1
        movzx   edx, BYTE PTR [esi+1]
        sub     edx, 48
        cmp     dl, 9
        jbe     .L1
        sub     esp, 8
        add     ebp, 4
        push    eax
        push    ebp
        call    add
        mov     edi, DWORD PTR [edi]
        lea     esi, [eax+ebx]
        add     esp, 16
        add     edi, 8
        jmp     .L9


create_tree:
        sub     esp, 36
        mov     DWORD PTR [esp+20], 0
        push    DWORD PTR [esp+40]
        lea     eax, [esp+24]
        push    eax
        call    add
        mov     eax, DWORD PTR [esp+28]
        add     esp, 44
        ret
