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
    ; Инициализация
    mov eax, [X]        ; Загружаем X в EAX
    mov ebx, [Y]        ; Загружаем Y в EBX
    mov ecx, [B3]       ; Загружаем B3 в ECX (не используется в данном коде)
    mov edx, [BB8]      ; Загружаем BB8 в EDX (не используется в данном коде)

    ; Цикл из F291
F291:
    sub eax, [X]        ; EAX = EAX - X
    sub eax, [Y]        ; EAX = EAX - Y
    sub eax, [Z]        ; EAX = EAX - Z (если Z определен, иначе уберите эту строку)
    mov L, eax          ; Сохраняем результат в L

    ; Вычисляем M
    mov eax, L          ; Загружаем L в EAX
    shr eax, 1          ; L / 2
    and eax, ebx        ; X & Y (где Y - это EBX)
    add M, eax          ; M = L / 2 + (X & Y)

    ; Переходы по условиям
    cmp M, 0x99F       ; Сравниваем M с 99F
    jl p1               ; Если M < 99F, переход к п/п 1
    jg p2               ; Если M > 99F, переход к п/п 2

p1:
    mov R, M           ; R = M
    jmp CheckEven       ; Переход к проверке четности

p2:
    add M, 0x10BA      ; R = M + 10BA
    mov R, M           ; R = M
    jmp CheckEven       ; Переход к проверке четности

CheckEven:
    mov eax, R         ; Загружаем R в EAX для проверки четности
    and eax, 1         ; Проверяем последний бит (четность)
    jz AADR1            ; Если четное, переход к AADR1
    jmp AADR2           ; Иначе переход к AADR2

AADR1:
    and R, FOF0F       ; R & FOF0F
    jmp exit            ; Завершение программы

AADR2:
    xor R, FOF0F       ; R xor FOF0F
    jmp exit            ; Завершение программы

exit:
    Invoke ExitProcess, 1
End Start