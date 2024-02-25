#![no_std]
#![no_main]

mod arch;
mod bsp;
mod lang_item;

fn kernel_init() -> ! {
    write_str("hello, zos!");

    loop {}
}

fn write_str(s: &str) {
    for c in s.chars() {
        unsafe {
            core::ptr::write_volatile(0x09000000 as *mut u8, c as u8);
        }
    }
}
