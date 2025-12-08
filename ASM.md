# DEUX SYNTAXE ASM

##  AT&T
Moins lisible (%,$ etc)

## INTEL
Plus lisible (%,$ etc)

# SECTION

- BSS
- RODATA
- TEXT

## BSS = Section ou l'on stock les variables non initialise 
ex : 
int age;
char buffer [256];


## RODATA = Section ou l'on stock les variables initialise
ex:
int age = 1337;
char buffer[] = "Hello world"

## TEXT = Section ou l'on stock tout le code qui va etre execute
ex:
les etiquettes,
les fonctions, 
etc,etc


# REGISTRE

ESPACE dans la stack qui pointe ver une valeur (stock des donnees)

64 bits              32 bits         16 bits

rax         |           eax     |       ax
rdi         |           edx     |       bx
rsi         |           ecx     |       cx
rdx         |           ebx     |       dx

# MOTS CLEF

## MOV

Pour mettre une valeur dans un registre.
- mov <destination> , <source>
Pour mettre 45 dans le registre rax (rax = 45):
mov rax , 45

## SYSCALL (traduction: appel systeme)

Appel kernel (donne la place au kernel pour faire un travail precis)
Depend de l'architecture ex: ELF 64 ELF 32 et PE 64 PE 32


## DB (traduction: define byte)

Sert a stocker 1 byte (1 char == 1 octet == 8 bits)
utiliser pour definir une chaine de char.


## DW (traduction: define word)

Sert a stocker 2 bytes (2 char == 2 octet == 16 bits)


## DD (traduction: define double word)

Sert a stocker 4 bytes (4 char == 4 octet == 32 bits)



Sert a stocker 2 byte (2 char == 2 octet == 16 bits)


## ETIQUETTE

Nom qui va pouvoir permettre de grouper ou d'organiser comme pa exemple le jmp qui va permettre de saute a un autre groupement.

nomEtiquette:
    jmp nomNouvelleEtiquette

nomNouvelleEtiquette:
    blablalabla

## OPERATEURS MATHEMATIQUE

### ADD

Faire une addition
ex:
mov rax,789
add rax,1337 (rax = 2126)

### SUB

Faire une soustraction
ex:
mov rax,789
add sub,1337 (rax = -548)

### DIV

Faire une division
ex:
mov rax,1337
mov rdi,50
div rdi (reviens a faire 1337/50 et la valeur de sortie sera stocker dans rax donc ici 26 et dans rdx le reste de la divison donc ici 37)


### MUL
Faire une multiplication
ex:
mov rax,1337
mov rdi,50
mul rdi (reviens a faire 1337 *50 et la valeur de sortie sera stocker dans rax donc ici 66850)


### DEMO (combinaison de plusieur operations)
Faire plusieur operations
ex:
mov rax,1337
mov rdi,50
mul rdi (reviens a faire 1337 *50 et la valeur de sortie sera stocker dans rax donc ici 66850)
add rax,1337( reviens a faire 1337 * 50 + 1337 donc valeur de sortie dans rax = 68187)

## STACK

### PUSH

Pousser une valeur dans la stack:
ex:
mov rax,45
push rax (la valeur de rax est pousser dans la stack)


### POP

Retirer (depiler) une valeur dans la stack et la mettre dans un registre:
ex:
mov rax,45
pop rdi (la valeur en tete de la stack donc ici 45 est pousser dans rdi et retirer de la stack)


## CONDITIONS

### CMP

Comparer un registre a une valeur
ex:
- cmp <register> , <value>

## FLAGS

## NON SIGNER (nombre seulement positif)

#### JE

(val1 = val2)
jump si val 1 est egal a val 2 

#### JA

(val1 > val2)
jump si val 1 est plus grande que val 2 


#### JAE

(val1 >= val2)
jump si val 1 est plus grande ou egal a val 2 


#### JAB

(val1 < val2)
jump si val 1 est plus petite que val 2 


#### JBE

(val1 <= val2)
jump si val 1 est plus petite ou egal a val 2 


## SIGNER (nombre negatif ou positif)

#### JG

(val1 > val2)
jump si val 1 est plus grande val 2 

#### JGE

(val1 >= val2)
jump si val 1 est plus grande ou egal a val 2 

#### JL

(val1 < val2)
jump si val 1 est plus petite que val 2 

#### JLE

(val1 <= val2)
jump si val 1 est plus petite ou egal a val 2 

## VERSION SPECIFIQUE (test certains bits de EFLAGS)

#### JC

(CF = 1)
jump si une retenue a ete genere

#### JO

(OF = 1)
jump si il y a eu un overflow

#### JZ

(ZF = 1)
jump si le dernier calcul a renvoyer 0

#### JS

(SF = 1)
jump si resultat du dernier calcul est negatif

## PS: Pour toutes ces instructions, il existe une version inverse.
ex:
jne (jump if not equa)


