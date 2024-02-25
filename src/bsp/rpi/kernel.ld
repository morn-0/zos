OUTPUT_ARCH(aarch64)
ENTRY(_start)
BASE_ADDRESS = 0x40080000;

SECTIONS
{
    . =  BASE_ADDRESS;

    .text : ALIGN(16) {
        *(.text*)
        *(.rodata*)
    }

    .data : ALIGN(16) {
        *(.data*)
    }

    .bss : ALIGN(16) {
        __bss_start = .;
        *(.bss*)
        __bss_end = .;
    }

    .stack : ALIGN(4096) {
        . = ALIGN(16);
        __stack_start = .;
        . = . + 0x4000;
        __stack_end = .;
    }
}
