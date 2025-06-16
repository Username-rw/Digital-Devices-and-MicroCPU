.686
.model flat,stdcall
.stack 100h

ExitProcess PROTO STDCALL :DWORD

.data
X   dd 02231h
Y   dd 048B3h
Z   dd 06BB8h

L   dd ?
M   dd ?
R   dd ?

.code
Start:
    ; L = F291h - X - Y - Z
    mov eax, 0F291h
    mov esi, offset X    ; ��������� �� X, Y, Z ������
    mov ecx, 3           ; 3 ��������

SubLoop:
    sub eax, [esi]
    add esi, 4           ; ������� � ���������� �������� 
    loop SubLoop

    mov L, eax

    ; M = L/2 + (X & Y)
    mov eax, L
    sar eax, 1           ; ������� �� 2 �� ������
    mov ebx, X
    and ebx, Y
    add eax, ebx
    mov M, eax

    ; ���� M < 099Fh => Proc1, ����� Proc2
    cmp eax, 0099Fh
    jl  PProc1           
    jmp PProc2

PProc1:
    Call Proc1
    ret

PProc2:
    Call Proc2
    ret

Proc1:
    ; R = ��.� <=> ��.� 
    mov eax, M
    xchg ah, al
    mov R, eax
    jmp CheckBits
    ret

Proc2:
    ; R = M + 10BAh
    mov eax, M
    add eax, 010BAh
    mov R, eax
    ret

CheckBits:
    ; �������� ���������� ������ � ������� ����� R
    mov eax, R
    mov bl, al         ; ������� ���� R � bl
    mov cl, 0
    mov bh, 8
CountBits:
    shr bl, 1
    adc cl, 0
    dec bh
    jnz CountBits

    test cl, 1         ; ������ �� ���������� ������?
    jz  Adr1           ; ���� ������, �� Adr1

Adr2:
    mov eax, R
    xor eax, 00F0Fh
    mov R, eax
    jmp Done

Adr1:
    mov eax, R
    and eax, 0F0F0h
    mov R, eax

Done:
    invoke ExitProcess, 0
End Start