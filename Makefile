PWD = $(shell pwd)
TARGET = aarch64-unknown-none

RUSTFLAGS = -C target-cpu=cortex-a72 \
			-C link-arg=--library-path=$(PWD)/src/bsp/rpi \
			-C link-arg=--script=kernel.ld \
			-C force-frame-pointers=yes

zos:
	@RUSTFLAGS="$(RUSTFLAGS)" cargo build --release --target $(TARGET) && \
		rust-objcopy --strip-all $(PWD)/target/$(TARGET)/release/zos -O binary $(PWD)/target/$(TARGET)/release/zos.bin
run: zos
	qemu-system-aarch64 -M virt -cpu cortex-a72 -serial stdio -display none -kernel $(PWD)/target/$(TARGET)/release/zos.bin
gdb: zos
	qemu-system-aarch64 -M virt -cpu cortex-a72 -serial stdio -display none -kernel $(PWD)/target/$(TARGET)/release/zos.bin -s -S
