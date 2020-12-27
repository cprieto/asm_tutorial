.PHONY: all clean

asm = $(wildcard lesson*.asm)
obj = $(addsuffix .o, $(basename $(wildcard lesson*.asm)))
exe = $(basename $(wildcard lesson*.asm))

all: $(exe)
clean:
	rm *.o

lesson%.o: lesson%.asm
	nasm -f elf32 $<

lesson%: lesson%.o
	ld -m elf_i386 $< -o $@
