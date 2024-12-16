🌞 Créer un répertoire de travail dans votre répertoire personnel

🌞 Retrouvez à l'aide de readelf l'architecture pour laquelle le programme est compilé

🌞 Afficher la liste des sections contenues dans le programme

🌞 Affichez le code assembleur de la section .text à l'aide d'objdump

🌞 Tracez à l'aide de la commande ldd les librairies appelées par...

🌞 Parmi les librairies appelées par hello2, déterminer le type du fichier nommé libc.so.X  





🌞 Retrouvez à l'aide de readelf l'architecture pour laquelle le programme est compilé

```
amimir@vbox:~/Desktop/Travaille$ readelf -h hello1
ELF Header:
  Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00
  Class:                             ELF32
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              DYN (Position-Independent Executable file)
  Machine:                           Intel 80386
  Version:                           0x1
  Entry point address:               0x1000
  Start of program headers:          52 (bytes into file)
  Start of section headers:          13320 (bytes into file)
  Flags:                             0x0
  Size of this header:               52 (bytes)
  Size of program headers:           32 (bytes)
  Number of program headers:         11
  Size of section headers:           40 (bytes)
  Number of section headers:         21
  Section header string table index: 20
```

🌞 Afficher la liste des sections contenues dans le programme

```
amimir@vbox:~/Desktop/Travaille$ readelf -S hello1
There are 21 section headers, starting at offset 0x3408:

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 0]                   NULL            00000000 000000 000000 00      0   0  0
  [ 1] .interp           PROGBITS        00000194 000194 000013 00   A  0   0  1
  [ 2] .note.gnu.bu[...] NOTE            000001a8 0001a8 000024 00   A  0   0  4
  [ 3] .gnu.hash         GNU_HASH        000001cc 0001cc 000018 04   A  4   0  4
  [ 4] .dynsym           DYNSYM          000001e4 0001e4 000010 10   A  5   1  4
  [ 5] .dynstr           STRTAB          000001f4 0001f4 000001 00   A  0   0  1
  [ 6] .text             PROGBITS        00001000 001000 00005d 00  AX  0   0  1
  [ 7] .eh_frame_hdr     PROGBITS        00002000 002000 00001c 00   A  0   0  4
  [ 8] .eh_frame         PROGBITS        0000201c 00201c 000058 00   A  0   0  4
  [ 9] .dynamic          DYNAMIC         00003f8c 002f8c 000068 08  WA  5   0  4
  [10] .got.plt          PROGBITS        00003ff4 002ff4 00000c 04  WA  0   0  4
  [11] .comment          PROGBITS        00000000 003000 00001f 01  MS  0   0  1
  [12] .debug_aranges    PROGBITS        00000000 00301f 000020 00      0   0  1
  [13] .debug_info       PROGBITS        00000000 00303f 000070 00      0   0  1
  [14] .debug_abbrev     PROGBITS        00000000 0030af 000062 00      0   0  1
  [15] .debug_line       PROGBITS        00000000 003111 000054 00      0   0  1
  [16] .debug_str        PROGBITS        00000000 003165 000085 01  MS  0   0  1
  [17] .debug_line_str   PROGBITS        00000000 0031ea 000028 01  MS  0   0  1
  [18] .symtab           SYMTAB          00000000 003214 0000b0 10     19   6  4
  [19] .strtab           STRTAB          00000000 0032c4 00006a 00      0   0  1
  [20] .shstrtab         STRTAB          00000000 00332e 0000d9 00      0   0  1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings), I (info),
  L (link order), O (extra OS processing required), G (group), T (TLS),
  C (compressed), x (unknown), o (OS specific), E (exclude),
  D (mbind), p (processor specific)
```

🌞 Affichez le code assembleur de la section .text à l'aide d'objdump

```
amimir@vbox:~/Desktop/Travaille$ objdump -M intel -j .text -s hello1

hello1:     file format elf32-i386

Contents of section .text:
 1000 5589e557 565383ec 10e84b00 000005e6  U..WVS....K.....
 1010 2f0000c7 45e54865 6c6cc745 e96f2c20  /...E.Hell.E.o,
 1020 57c745ed 6f726c64 c745f064 210a008d  W.E.orld.E.d!...
 1030 75e5bf0e 000000b8 04000000 bb010000  u...............
 1040 0089f189 facd80b8 01000000 31dbcd80  ............1...
 1050 9083c410 5b5e5f5d c38b0424 c3        ....[^_]...$.
```

🌞 Tracez à l'aide de la commande ldd les librairies appelées par...

hello2:

```
amimir@vbox:~/Desktop/Travaille$ ldd hello2
        linux-gate.so.1 (0xf7ef4000)
        libc.so.6 => /lib32/libc.so.6 (0xf7cb0000)
        /lib/ld-linux.so.2 (0xf7ef6000)
```

hello1:

```
amimir@vbox:~/Desktop/Travaille$ ldd hello1
        statically linked
```

ls:

```
amimir@vbox:~$ ldd /usr/bin/ls
        linux-vdso.so.1 (0x00007ffebdf62000)
        libselinux.so.1 => /lib/x86_64-linux-gnu/libselinux.so.1 (0x00007fc331cc1000)
        libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007fc331ae0000)
        libpcre2-8.so.0 => /lib/x86_64-linux-gnu/libpcre2-8.so.0 (0x00007fc331a46000)
        /lib64/ld-linux-x86-64.so.2 (0x00007fc331d28000)
```

firefox:
```
amimir@vbox:~$ ldd /usr/bin/firefox
        not a dynamic executable
```

🌞 Parmi les librairies appelées par hello2, déterminer le type du fichier nommé libc.so.X

```
amimir@vbox:~/Desktop/Travaille$ ldd hello2
        linux-gate.so.1 (0xf7f0f000)
        libc.so.6 => /lib32/libc.so.6 (0xf7ccb000)
        /lib/ld-linux.so.2 (0xf7f11000)
amimir@vbox:~/Desktop/Travaille$ file libc.so.6
libc.so.6: cannot open `libc.so.6' (No such file or directory)
amimir@vbox:~/Desktop/Travaille$ file /lib32/libc.so.6
/lib32/libc.so.6: ELF 32-bit LSB shared object, Intel 80386, version 1 (GNU/Linux), dynamically linked, interpreter /lib/ld-linux.so.2, BuildID[sha1]=b3f5646d25dc90cc34d2507f197561065c7e630c, for GNU/Linux 3.2.0, stripped
```

🌞 Affichez le type des fichiers hello2 et hello3

```
amimir@vbox:~/Desktop/Travaille$ cp hello2.c hello3.c
amimir@vbox:~/Desktop/Travaille$ ls
hello1  hello1.c  hello2  hello2.c  hello3.c
amimir@vbox:~/Desktop/Travaille$ gcc -static -fno-stack-protector -g -m32 -o hello3 hello3.c
amimir@vbox:~/Desktop/Travaille$ file hello2
hello2: ELF 32-bit LSB pie executable, Intel 80386, version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux.so.2, BuildID[sha1]=974d9b5cc431581db1941c5386eeb568199ba6e8, for GNU/Linux 3.2.0, with debug_info, not stripped
amimir@vbox:~/Desktop/Travaille$ file hello3
hello3: ELF 32-bit LSB executable, Intel 80386, version 1 (GNU/Linux), statically linked, BuildID[sha1]=39569e443d7991e1bc44d6a3f73292489114e9f8, for GNU/Linux 3.2.0, with debug_info, not stripped
```

🌞 Affichez leurs tailles

```
amimir@vbox:~/Desktop/Travaille$ du -h -k hello2
16      hello2
amimir@vbox:~/Desktop/Travaille$ du -h -k hello3
728     hello3
```

🌞 Affichez l'architecture de votre CPU

```
amimir@vbox:~/Desktop/Travaille$ sudo cat /proc/cpuinfo
[sudo] password for amimir:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 154
model name      : 12th Gen Intel(R) Core(TM) i7-12650H
stepping        : 3
microcode       : 0xffffffff
cpu MHz         : 2687.974
cache size      : 24576 KB
physical id     : 0
siblings        : 1
core id         : 0
cpu cores       : 1
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx rdtscp lm constant_tsc rep_good nopl xtopology nonstop_tsc cpuid tsc_known_freq pni pclmulqdq ssse3 cx16 sse4_1 sse4_2 movbe popcnt aes rdrand hypervisor lahf_lm abm 3dnowprefetch ibrs_enhanced fsgsbase bmi1 bmi2 invpcid rdseed adx clflushopt sha_ni arat md_clear flush_l1d arch_capabilities
bugs            : spectre_v1 spectre_v2 spec_store_bypass swapgs retbleed eibrs_pbrsb rfds bhi
bogomips        : 5375.94
clflush size    : 64
cache_alignment : 64
address sizes   : 39 bits physical, 48 bits virtual
power management:
```

🌞 Vérifiez que vous avez la commande x86-64-linux-gnu-gcc

```
amimir@vbox:~/Desktop/Travaille$ x86_64-linux-gnu-gcc --version
x86_64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0
Copyright (C) 2022 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.O
```

🌞 Compilez votre fichier hello3.c dans un fichier cible nommé hello4 vers une autre architecture que la vôtre

```
amimir@vbox:~/Desktop/Travaille$ aarch64-linux-gnu-gcc -static -fno-stack-protector -g -o hello4 hello3.c
amimir@vbox:~/Desktop/Travaille$ ls
hello1  hello1.c  hello2  hello2.c  hello3  hello3.c  hello4
```

🌞 Désassemblez hello3 et hello4 à l'aide d'objdump

```
amimir@vbox:~/Desktop/Travaille$ objdump -M intel -j .text -d hello3
amimir@vbox:~/Desktop/Travaille$ objdump -M intel -j .text -d hello4
```

🌞 Essayez d'exécuter le programme hello4

```
amimir@vbox:~/Desktop/Travaille$ ./hello4
-bash: ./hello4: cannot execute binary file: Exec format error
```