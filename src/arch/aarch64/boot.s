.macro ADR_REL register, symbol
    adrp \register, \symbol
    add \register, \register, #:lo12:\symbol
.endm

.section .text._start

.global _start

_start:
    ADR_REL x0, __bss_start
    ADR_REL x1, __bss_end

_bss_init:
    cmp x0, x1
    b.eq _rust_init
    stp xzr, xzr, [x0], #16
    b _bss_init

_rust_init:
    ADR_REL x0, __stack_end
    mov sp, x0
    b rust_init

.size _start, . - _start
.type _start, function
