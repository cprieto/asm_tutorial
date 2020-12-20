ls
cd
ls
exit
cd
ls
nasm -f elf -o test.o test.asm
exit
nasm -f elf -o test.o test.asm
ls
cd
nasm -f elf -o test.o test.asm
ls
ld -m elf_i386 -o test test.o
ls
./test
exit
cd
nasm -f elf -o test.o test.asm
ld -m elf_i386 -o test test.o
exit
nasm -f elf -o test.o test.asm
cd
nasm -f elf -o test.o test.asm
ls
ld -m elf_i386 -o test test.o
ls
./test
exit
