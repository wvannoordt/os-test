.PHONY: run
asm: clean kernel
	nasm bootstrap.asm -f bin -o boot_sect.bin
	nasm kernel_entry.asm -f elf -o kernel_entry.o
	ld -m elf_i386 -s -o kernel.bin -Ttext 0x1000 kernel_entry.o kernel.o --oformat binary
	cat boot_sect.bin kernel.bin > os-image
	qemu-system-x86_64 os-image

kernel:
	gcc -m32 -fno-pie -ffreestanding -c kernel.c -o kernel.o
	# ld -o kernel.bin -Ttext 0x0 --oformat binary kernel.o

run: main
	./program

main:
	g++ main.cc -o program

clean:
	-rm -f *.bin
	-rm -f os-image
	-rm -f *.o