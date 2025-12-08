# ASM


## Pour compiler:

Transformer le fichier .asm ou .as en .o
Pour specifier un nom de fichier .o
sh```
nasm -f elf64 <nom_du_fichier> -o <nom_du_fichier.o>
```

Sinon nom de fichier .o pareil au nom du fichier .asm ou .s par default
sh```
nasm -f elf64 <nom_du_fichier>
```

Exemple:
sh```
nasm -f elf64 reverse_shell.s
```

Cree l'executable a partir du fichier .o'

sh```
ld <nom_du_fichier.o> -o <nom_du_prog>
```

Exemple:
sh```
ld reverse_shell.o -o reverse_shell
```

### Pour le reverse shell

Sur la machine de l'attaquant faire :

sh```
nc -lvp <numero de port>
```

Exemple avec port defini dans le prog (mais modifiable)

sh```
nc -lvp 4444 
```

Et sur la machine de la victime executer le prog 


