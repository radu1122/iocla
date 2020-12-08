
section .data
    delim db " ", 0

section .bss
    root resd 1

section .text

extern evaluate_ast
extern malloc
extern strndup
global create_tree
global iocla_atoi

iocla_atoi:
        push    esi
        push    ebx
        xor     ecx, ecx
        mov     eax, DWORD PTR [esp+12]
        mov     esi, 1
        movsx   edx, BYTE PTR [eax]
        cmp     dl, 45
        jne     .L2iocla_atoi
        movsx   edx, BYTE PTR [eax+1]
        mov     esi, -1
        mov     ecx, 1
.L2iocla_atoi:
        lea     ebx, [edx-48]
        lea     ecx, [eax+1+ecx]
        xor     eax, eax
        cmp     bl, 9
        ja      .L1iocla_atoi
.L3iocla_atoi:
        lea     ebx, [eax+eax*4]
        add     ecx, 1
        lea     eax, [edx-48+ebx*2]
        movsx   edx, BYTE PTR [ecx-1]
        lea     ebx, [edx-48]
        cmp     bl, 9
        jbe     .L3iocla_atoi
        imul    eax, esi
.L1iocla_atoi:
        pop     ebx
        pop     esi
        ret

add_tree:
        push    ebp
        push    edi
        push    esi
        push    ebx
        sub     esp, 12
        mov     edi, DWORD [esp+32]
        mov     esi, DWORD [esp+36]
.L9:
        movzx   edx, BYTE [esi]
        cmp     dl, 32
        jne     .L2
        movzx   edx, BYTE [esi+1]
        add     esi, 1
.L2:
        test    dl, dl
        je      .L3
        mov     ebp, DWORD [edi]
        mov     ebx, 1
        test    ebp, ebp
        jne     .L5
        sub     esp, 12
        mov     ebx, 1
        push    12
        call    malloc
        mov     ebp, eax
        movzx   eax, BYTE [esi+1]
        add     esp, 16
        sub     eax, 48
        cmp     al, 9
        jbe     .L7
.L6:
        sub     esp, 8
        push    ebx
        push    esi
        call    strndup
        mov     DWORD [ebp+4], 0
        mov     DWORD [ebp+0], eax
        add     esp, 16
        mov     DWORD [ebp+8], 0
        mov     DWORD [edi], ebp
        movzx   edx, BYTE [esi]
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
        movzx   eax, BYTE [esi+ebx]
        lea     edx, [eax-48]
        cmp     dl, 9
        ja      .L6
        add     ebx, 1
        movzx   eax, BYTE [esi+ebx]
        lea     edx, [eax-48]
        cmp     dl, 9
        jbe     .L7
        jmp     .L6
.L5:
        sub     edx, 48
        lea     eax, [esi+ebx]
        cmp     dl, 9
        jbe     .L1
        movzx   edx, BYTE [esi+1]
        sub     edx, 48
        cmp     dl, 9
        jbe     .L1
        sub     esp, 8
        add     ebp, 4
        push    eax
        push    ebp
        call    add_tree
        mov     edi, DWORD [edi]
        lea     esi, [eax+ebx]
        add     esp, 16
        add     edi, 8
        jmp     .L9


create_tree:
        sub     esp, 36
        mov     DWORD [esp+20], 0
        push    DWORD [esp+40]
        lea     eax, [esp+24]
        push    eax
        call    add_tree
        mov     eax, DWORD [esp+28]
        add     esp, 44
        ret
