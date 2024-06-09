
    .global _start
_start:
    addi x1, x0, 3
    addi x2, x1, -1
loop:
    j loop
