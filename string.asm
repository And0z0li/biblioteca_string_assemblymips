#Discente: Mikéias Gabriel Maia Azevedo
#Biblioteca de funções para manipulação de strings
.text
#---------------------------------------------------------------------------------------------------
#Função: Strlen
	strlen:
		addi $sp, $sp, -4	#ajusta pilha para mais 1 item
		sw $s0, 0($sp)		#salva $s0
		
		addi $s0, $zero, 0	#s0 = i = 0 (variável para mover o ponteiro)
		
	strlen_corpo:
		add $t0, $s0, $a0	#recebe o endereço da string + i
		lb $t1, 0($t0)		#recebe a letra 
		beq $t1, $zero, strlen_fim	#compara se não é o fim da string "\0"
		
		addi $s0, $s0, 1 	#incremento $s0++ 
		j strlen_corpo		#retorna para o corpo se não cumprir a condição
		
	strlen_fim:
		addi $s0, $s0, -1
		addi $v0, $s0, 0	#passa o resultado para a variável de retorno $v0
		lw $s0, 0($sp)		#salva o valor de $s0
		addi $sp, $sp, 4	#retira 1 word da pilha
		jr $ra			#retorna
		
#---------------------------------------------------------------------------------------------------
	
	#---------------------------------------------------------------------------------------------------
	#Função: Strcmp
	strcmp:
		addi $sp, $sp, -4	#ajusta pilha para mais 1 item
		sw $s0, 0($sp)		#salva $s0
		add	$s0, $zero, $zero	#s0 = i = 0 (variável para mover o ponteiro)
	
	strcmp_corpo:
		
		add $t1, $s0, $a1		#endereço de src[i] em $t1
		lb $t2, 0($t1)			# $t2 = src[i]
		add $t3, $s0, $a0		#endereço de dest[i] em $t3
		lb $t4, 0($t3)			# $t4 = dest[i]
		bne $t2, $t4, str_not_equal	#compara se são iguais
		beq $t2, $zero, str_equal	#vê se não chegou no fim da string
		addi $s0, $s0, 1		# incrementa $s0++ ou i++
		j strcmp_corpo			#retorna para o corpo se não cumprir a condição
	
	str_not_equal:		
		addi $v0, $zero, 0		#salva 0 na variável de retorno se não forem iguais
		j strcmp_exit			#vai para o label de saida
	
	str_equal:
		addi $v0, $zero, 1		#salva 1 na variável de retorno se forem iguais
		j strcmp_exit			#vai para o label de saida
		
	strcmp_exit:
		lw $s0, 0($sp)			#salva o valor de $s0
		addi	$sp, $sp, 4		#retira 1 word da pilha
		jr $ra				#retorna
	#---------------------------------------------------------------------------------------------------
	
	#---------------------------------------------------------------------------------------------------
	#Função: strcat
	
	strcat:
	 	addi $sp, $sp, -12		#aloca espaço par
		sw $ra, 0($sp) 		#Atribui $ra para a 
		sw $s0, 4($sp) 		#Atribui $s0 para a 
		sw $s1, 8($sp) 		#Atribui $s1 para a 
		#pegando o tamanho da string1
		jal strlen
	
		add $s0, $v0, $zero		# i = $v0+0 // $
		add $s1, $zero, $zero	# y = 0+0	
		
	
						
	strcat_corpo:
		add $t1, $s1, $a1		#endereço de string2(src) + y
		add $t3, $s0, $a0		#endereço de string1(dest) + i
		lb $t2, 0($t1)		#$t2 = letra de string2		
		sb $t2, 0($t3)		#stirngDestino[i] = 
		beq $t2, $zero, strcat_exit	#se i == c
		addi $s1, $s1, 1		#y = y+1
		addi $s0, $s0, 1		#i = i+1
		j strcat_corpo		#repete se não cumpriu a condição
		
	strcat_exit:
		
		add  $v0, $zero, $a0		#atribuindo o r
		lw $ra, 0($sp)		#retorna o valor $ra 
		lw $s0, 4($sp) 		#retorna o valor $s0 
		lw $s1, 8($sp) 		#retorna o valor $s1 
		addi $sp, $sp, 12		#libera o espaço na pilha
		
		jr $ra			#retorna
		
	#---------------------------------------------------------------------------------------------------
	
	#---------------------------------------------------------------------------------------------------
	#Função Strncat
	strncat:
	
		addi $sp, $sp, -12		#libera espaço na pilha
		sw $ra, 0($sp) 		#Atribui $ra para a 
		sw $s0, 4($sp) 		#Atribui $s0 para a 
		sw $s1, 8($sp) 		#Atribui $s1 para a 
		
		#pegando o tamanho da string1
		jal strlen
		
		add $s0, $v0, $zero		# i = $v0+0 // $
		add $s1, $zero, $zero	# y = 0+0	
	strncat_corpo:
		
		add $t1, $s1, $a1		#endereço de string2(src) + y
		add $t3, $s0, $a0		#endereço de string1(dest) + i
		lb $t2, 0($t1)		#$t2 = letra de string2		
		sb $t2, 0($t3)		#stirngDestino[i] = 
		
		addi $a2, $a2, -1		#decremento da quantidade
		beq $a2, $zero, strncat_exit	#se i == c
		beq $t2, $zero, strncat_exit	#se i == c
		
		addi $s1, $s1, 1		#y = y+1
		addi $s0, $s0, 1		#i = i+1
		j strncat_corpo		#repete se não cumpriu a condição
		
	strncat_exit:
		add $v0, $a0, $zero 		#atribuindo o r
		lw $ra, 0($sp)		#retorna o valor $ra 
		addi $sp, $sp, 4		#libera o espaço qu
		
		jr $ra			#retorna
		
	#---------------------------------------------------------------------------------------------------
	
	#---------------------------------------------------------------------------------------------------
	#Função: Strncpy
	strncpy:
		addi $sp, $sp, -4	#ajusta pilha para mais 1 item
		sw $s0, 0($sp)		#salva $s0
		add $s0, $zero, $zero	#i = 0+0
	
	strncpy_corpo:	
		slti $t3, $a2, 1 	 #testa se o valor de $a2 não é/está abaixo de 1
		beq $t3, 1, strncpy_exit #finaliza a função se estiver
		
		add $t1, $s0, $a1	#endereço de src[i] em $t1
		lb $t2, 0($t1)		# $t2 = src[i]
		add $t3, $s0, $a0	#endereço de dest[i] em $t3
		sb $t2, 0($t3)		# dest[i] = src[i]
		beq $t2, $zero, strncpy_exit	#se src[i] == 0, vai para o fim do programa
		addi $s0, $s0, 1		# i = i+1
		addi $a2, $a2, -1		#decrementa o parâmetro passado pelo usuário da quantidade 
		j strncpy_corpo			# repete até cumprir uma das condições
	
	strncpy_exit: 	
		#coloca \0 no fim da string destino
		addi $s0, $s0, 1	# i = i+1
		add $t3, $s0, $a0	#endereço de dest[i] em $t3
		sb $zero, 0($t3)	# dest[i] = \0 (Coloca o \0 no fim da string)
		
		add $v0, $a0, $zero
		lw $s0, 0($sp)		#restaura $s0
		addi $sp, $sp, 4	#retira 2 word da pilha
		jr $ra			#retorna
	#---------------------------------------------------------------------------------------------------
