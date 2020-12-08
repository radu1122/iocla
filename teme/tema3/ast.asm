
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
        mov     eax, DWORD [esp + 12]
        mov     esi, 1
        movsx   edx, BYTE [eax]
        cmp     dl, 45 ; check if string[0] == '-'
        jne     atoi_negative_number
        movsx   edx, BYTE [eax + 1]
        mov     esi, -1
        mov     ecx, 1
atoi_negative_number:
        lea     ebx, [edx - 48]
        lea     ecx, [eax + 1 + ecx]
        xor     eax, eax
        cmp     bl, 9 ; check if number
        ja      iocla_atoi_final
atoi_string_iterator:
        lea     ebx, [eax + eax * 4]
        add     ecx, 1
        lea     eax, [edx - 48 + ebx * 2]
        movsx   edx, BYTE [ecx - 1]
        lea     ebx, [edx - 48]
        cmp     bl, 9 ; check if number
        jbe     atoi_string_iterator
        imul    eax, esi
iocla_atoi_final:
        pop     ebx
        pop     esi
        ret

add_node:
        push    ebp
        push    edi
        push    esi
        push    ebx
        sub     esp, 12
        mov     edi, DWORD [esp + 32]
        mov     esi, DWORD [esp + 36]
start_algo_add_node:
        movzx   edx, BYTE [esi]
        cmp     dl, 32
        jne     start_while_true
        movzx   edx, BYTE [esi + 1]
        add     esi, 1
start_while_true:
        test    dl, dl
        je      finish_iterator
        mov     ebp, DWORD [edi]
        mov     ebx, 1
        test    ebp, ebp
        jne     check_if_number
        sub     esp, 12
        mov     ebx, 1
        push    12
        call    malloc
        mov     ebp, eax
        movzx   eax, BYTE [esi+1]
        add     esp, 16
        sub     eax, 48
        cmp     al, 9
        jbe     iterate_string_check_number
create_node_in_memory:
        sub     esp, 8
        push    ebx
        push    esi
        call    strndup ; duplicate the number from the string
        mov     DWORD [ebp+4], 0
        mov     DWORD [ebp+0], eax
        add     esp, 16
        mov     DWORD [ebp+8], 0
        mov     DWORD [edi], ebp
        movzx   edx, BYTE [esi]
        test    dl, dl
        jne     check_if_number
finish_iterator:
        xor     eax, eax
add_node_return:
        add     esp, 12
        pop     ebx
        pop     esi
        pop     edi
        pop     ebp
        ret
iterate_string_check_number:
        add     ebx, 1
        movzx   eax, BYTE [esi+ebx]
        lea     edx, [eax-48]
        cmp     dl, 9
        ja      create_node_in_memory
        add     ebx, 1
        movzx   eax, BYTE [esi+ebx]
        lea     edx, [eax-48]
        cmp     dl, 9
        jbe     iterate_string_check_number
        jmp     create_node_in_memory
check_if_number:
        sub     edx, 48
        lea     eax, [esi+ebx]
        cmp     dl, 9
        jbe     finish_iterator
        movzx   edx, BYTE [esi+1]
        sub     edx, 48
        cmp     dl, 9
        jbe     finish_iterator
        sub     esp, 8
        add     ebp, 4
        push    eax
        push    ebp
        call    add_node ; add left child 
        mov     edi, DWORD [edi]
        lea     esi, [eax+ebx]
        add     esp, 16
        add     edi, 8
        jmp     start_algo_add_node ; add rigth child


create_tree:
        sub     esp, 36
        mov     DWORD [esp + 20], 0
        push    DWORD [esp + 40]
        lea     eax, [esp + 24]
        push    eax
        call    add_node
        mov     eax, DWORD [esp + 28]
        add     esp, 44
        ret
