#Discente: Mik�ias Gabriel Maia Azevedo
#Menu com chamada de fun��es que manipulam strings
.data
	msg1: .asciiz "Escolha uma das op��es abaixo:\n1 - strlen\n2 - strcmp\n3 - strcat\n4 - strncat\n5 - strncpy\n0 - Sair  "
	msg2: .asciiz "\nString1: "
	msg3: .asciiz "\nString2: "
	msg4: .asciiz "\nDigite uma string com at� 20 caracteres: "
	msg_qtd: .asciiz "\nDigite uma quantidade de elementos para a fun��o executar: "
	msg_resposta: .asciiz "\nResultado: "
	string1: .space 40
	string2: .space 20
	
	
.text
.globl main #define o label main como um label global	
	main: 
	
		la $a0, msg1 #passa o endere�o da mensagem inicial para $a0
		li $v0, 4    #passa o c�digo do call para mostrar a mensagem
		syscall      #executa a diretiva que mostra a mensagem
	
		li $v0, 5    #passa o c�digo do call para ler um inteiro
		syscall	     #executa a diretiva para ler um inteiro, a resposta fica em $v0
		
		beq $v0, 1, chamada_strlen #testa as op��es para executar os m�todos que o usu�rio escolher
		beq $v0, 2, chamada_strcmp 
		beq $v0, 3, chamada_strcat
		beq $v0, 4, chamada_strncat
		beq $v0, 5, chamada_strncpy
		beq $v0, 0, exit
	
		j main #se n�o for escolhida nenhuma op��o, retorna para o main
	
	chamada_strlen:
		#Pede para entrar com uma string
		la $a0, msg4	 #recebe o endere�o da mensagem: msg2
		li $v0, 4	#coloca o valor da chamada	
		syscall	
		
		la $a0, string1
		li $a1, 20
		li $v0, 8
		syscall

			
		#mostra a string1: 
		la $a0, msg2	 #recebe o endere�o da mensagem: String1
		li $v0, 4	#coloca o valor da chamada	
		syscall		
		
		la $a0, string1	 #recebe o endere�o da string
		li $v0, 4	#coloca o valor da chamada	
		syscall
			
		jal strlen	#chama a fun��o e salva o endere�o seguinte em $ra
		
		add $t0, $v0, $zero #salva o valor de retorno em $t0
		
		la $a0, msg_resposta #mostra o resultado
		li $v0, 4
		syscall
		
		add $a0, $zero, $t0 #mostra o inteiro retornado
		li $v0, 1
		syscall
				
		j main		#retorna para o main ao fim da execu��o
	
	chamada_strcmp:
		#Pede para entrar com uma string
		la $a0, msg4	 #recebe o endere�o da mensagem: msg2
		li $v0, 4	#coloca o valor da chamada	
		syscall	
		
		la $a0, string1
		li $a1, 20
		li $v0, 8
		syscall
		
		#Pede para entrar com uma string
		la $a0, msg4	 #recebe o endere�o da mensagem: msg2
		li $v0, 4	#coloca o valor da chamada	
		syscall	
		
		la $a0, string2
		li $a1, 20
		li $v0, 8
		syscall

		#mostra a string1: 
		la $a0, msg2	 #recebe o endere�o da mensagem: String1
		li $v0, 4	#coloca o valor da chamada	
		syscall	
		
		la $a0, string1	 #recebe o endere�o da string
		li $v0, 4	#coloca o valor da chamada	
		syscall
		
		#mostra a string2: 
		la $a0, msg3	 #recebe o endere�o da mensagem: String2
		li $v0, 4	#coloca o valor da chamada	
		syscall	
		
		la $a0, string2	 #recebe o endere�o da string
		li $v0, 4	#coloca o valor da chamada	
		syscall
	
		la $a0, string1 #passa a string para a vari�vel de par�metro $a0
		la $a1, string2 #passa a string para a vari�vel de par�metro $a1
		jal strcmp	#chama a fun��o e salva o endere�o seguinte em $ra
	
		add $t0, $v0, $zero #salva o valor de retorno em $t0
	
		la $a0, msg_resposta #mostra o resultado
		li $v0, 4
		syscall
		
		add $a0, $zero, $t0 #mostra o inteiro retornado
		li $v0, 1
		syscall
	
		j main		#retorna para o main ao fim da execu��o
	
	chamada_strcat:
		#Pede para entrar com uma string
		la $a0, msg4	 #recebe o endere�o da mensagem: msg2
		li $v0, 4	#coloca o valor da chamada	
		syscall	
		
		la $a0, string1
		li $a1, 20
		li $v0, 8
		syscall
		
		#Pede para entrar com uma string
		la $a0, msg4	 #recebe o endere�o da mensagem: msg2
		li $v0, 4	#coloca o valor da chamada	
		syscall	
		
		la $a0, string2
		li $a1, 20
		li $v0, 8
		syscall

		#mostra a string1: 
		la $a0, msg2	 #recebe o endere�o da mensagem: String1
		li $v0, 4	#coloca o valor da chamada	
		syscall	
		
		la $a0, string1	 #recebe o endere�o da string
		li $v0, 4	#coloca o valor da chamada	
		syscall
		
		#mostra a string2: 
		la $a0, msg3	 #recebe o endere�o da mensagem: String2
		li $v0, 4	#coloca o valor da chamada	
		syscall	
		
		la $a0, string2	 #recebe o endere�o da string
		li $v0, 4	#coloca o valor da chamada	
		syscall
	

		la $a0, string1	#passa a string para a vari�vel de par�metro $a0
		la $a1, string2	#passa a string para a vari�vel de par�metro $a1	
		jal strcat	#chama a fun��o e salva o endere�o seguinte em $ra
	
		add $t0, $v0, $zero #salva o valor de retorno em $t0
		
		la $a0, msg_resposta #mostra o resultado
		li $v0, 4
		syscall
	
		add $a0, $t0, $zero  #salva o endere�o de retorno em $a0 para mostrar
		li $v0, 4
		syscall
	
		j main		#retorna para o main ao fim da execu��o

	chamada_strncat:
		#Pede para entrar com uma string
		la $a0, msg4	 #recebe o endere�o da mensagem: msg2
		li $v0, 4	#coloca o valor da chamada	
		syscall	
		
		la $a0, string1
		li $a1, 20
		li $v0, 8
		syscall	
	
		#Pede para entrar com uma string
		la $a0, msg4	 #recebe o endere�o da mensagem: msg2
		li $v0, 4	#coloca o valor da chamada	
		syscall	
		
		la $a0, string2
		li $a1, 20
		li $v0, 8
		syscall
	
		#Pede para entrar com uma string
		la $a0, msg_qtd	 #recebe o endere�o da mensagem: msg2
		li $v0, 4	#coloca o valor da chamada	
		syscall	
		
		li $v0, 5
		syscall
	
		la $a0, string1	#passa a string para a vari�vel de par�metro $a0
		la $a1, string2	#passa a string para a vari�vel de par�metro $a1
		add $a2, $v0, $zero #passa um inteiro para a vari�vel de par�metro $a2
		jal strncat	#chama a fun��o e salva o endere�o seguinte em $ra
	
		add $t0, $v0, $zero #salva o valor de retorno em $t0
	
		la $a0, msg_resposta #mostra o resultado
		li $v0, 4
		syscall
	
		add $a0, $t0, $zero  #salva o endere�o de retorno em $a0 para mostrar
		li $v0, 4
		syscall
	
		j main		#retorna para o main ao fim da execu��o

	chamada_strncpy:
		#Pede para entrar com uma string
		la $a0, msg4	 #recebe o endere�o da mensagem: msg2
		li $v0, 4	#coloca o valor da chamada	
		syscall	
		
		la $a0, string2
		li $a1, 20
		li $v0, 8
		syscall	
		
		#Pede para entrar com uma string
		la $a0, msg_qtd	 #recebe o endere�o da mensagem: msg2
		li $v0, 4	#coloca o valor da chamada	
		syscall	
		
		li $v0, 5
		syscall
	
		la $a0, string1	#passa a string para a vari�vel de par�metro $a0
		la $a1, string2	#passa a string para a vari�vel de par�metro $a1
		add $a2, $v0, $zero	#passa um inteiro para a vari�vel de par�metro $a2
		jal strncpy	#chama a fun��o e salva o endere�o seguinte em $ra
	
		add $t0, $v0, $zero #salva o valor de retorno em $t0
	
		la $a0, msg_resposta #mostra o resultado
		li $v0, 4
		syscall
	
		add $a0, $t0, $zero  #salva o endere�o de retorno em $a0 para mostrar
		li $v0, 4
		syscall
	
		j main		#retorna para o main ao fim da execu��o

	exit:
		li $v0, 10	#passa o c�digo para finalizar o programa
		syscall		#executa a diretiva
	
.include "string.asm"	#include das fun��es
