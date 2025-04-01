.686
.model flat, stdcall

.stack 100h

.data
X DWORD 2231
Y DWORD 48
B3 DWORD 6
BB8 DWORD 0xBB8
L DWORD ?
M DWORD ?
R DWORD ?
FOF0F DWORD 0x0F0F

.code
ExitProcess PROTO STDCALL :DWORD

Start:
    ; �������������
    mov eax, [X]        ; ��������� X � EAX
    mov ebx, [Y]        ; ��������� Y � EBX
    mov ecx, [B3]       ; ��������� B3 � ECX (�� ������������ � ������ ����)
    mov edx, [BB8]      ; ��������� BB8 � EDX (�� ������������ � ������ ����)

    ; ���� �� F291
F291:
    sub eax, [X]        ; EAX = EAX - X
    sub eax, [Y]        ; EAX = EAX - Y
    sub eax, [Z]        ; EAX = EAX - Z (���� Z ���������, ����� ������� ��� ������)
    mov L, eax          ; ��������� ��������� � L

    ; ��������� M
    mov eax, L          ; ��������� L � EAX
    shr eax, 1          ; L / 2
    and eax, ebx        ; X & Y (��� Y - ��� EBX)
    add M, eax          ; M = L / 2 + (X & Y)

    ; �������� �� ��������
    cmp M, 0x99F       ; ���������� M � 99F
    jl p1               ; ���� M < 99F, ������� � �/� 1
    jg p2               ; ���� M > 99F, ������� � �/� 2

p1:
    mov R, M           ; R = M
    jmp CheckEven       ; ������� � �������� ��������

p2:
    add M, 0x10BA      ; R = M + 10BA
    mov R, M           ; R = M
    jmp CheckEven       ; ������� � �������� ��������

CheckEven:
    mov eax, R         ; ��������� R � EAX ��� �������� ��������
    and eax, 1         ; ��������� ��������� ��� (��������)
    jz AADR1            ; ���� ������, ������� � AADR1
    jmp AADR2           ; ����� ������� � AADR2

AADR1:
    and R, FOF0F       ; R & FOF0F
    jmp exit            ; ���������� ���������

AADR2:
    xor R, FOF0F       ; R xor FOF0F
    jmp exit            ; ���������� ���������

exit:
    Invoke ExitProcess, 1
End Start