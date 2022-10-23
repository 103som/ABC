	.intel_syntax noprefix                # Используем синтаксис в стиле Intel
	.text                                 # Начало секции.
	.globl	bubbleSort                    # Объявляем и экспортируем bubbleSort.
	.type	bubbleSort, @function         # Отмечаем, что это функция.
bubbleSort:
	push	rbp                           # Стандартный пролог функции.
	mov	rbp, rsp                      # Стандартный пролог функции.
	
	# Загрузка параметров в стек.  
	mov	QWORD PTR -24[rbp], rdi       # arr
	mov	DWORD PTR -28[rbp], esi       # n
	mov	DWORD PTR -4[rbp], 0          # i = 0
	jmp	.L2                           # Переход к метке L2 по коду(к сравнению цикла).
.L6:
        # Зашли внутрь цикла первого цикла.
	mov	eax, DWORD PTR -28[rbp]
	sub	eax, 1                        # Увеличили i.
	mov	DWORD PTR -8[rbp], eax       
	jmp	.L3                           # Переходим к условию второго цикла.
.L5:
	mov	eax, DWORD PTR -8[rbp]        # Загрузка из стека.
	
	# Загрузка arr[j - 1] и arr[j].
	sal	rax, 2
	lea	rdx, -4[rax]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	edx, DWORD PTR [rax]
	mov	eax, DWORD PTR -8[rbp]
	lea	rcx, 0[0+rax*4]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rcx
	mov	eax, DWORD PTR [rax]
	#
	
	cmp	edx, eax                       # Сравнение (arr[j - 1] < arr[j])
	jge	.L4
	# Если условие выполнено, то выполняем инструкции внутри блока if.
	# Работа с памятью и выполнение строки кода (int temp = arr[j - 1];).
	mov	eax, DWORD PTR -8[rbp]
	sal	rax, 2
	lea	rdx, -4[rax]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR -12[rbp], eax
	#
	
	# Работа с памятью и выполнение строки кода (arr[j - 1] = arr[j];).
	mov	eax, DWORD PTR -8[rbp]    # Присваиваем rax элемент из A.
	lea	rdx, 0[0+rax*4]           # rdx = rax * 4.
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx                  # Приравниваем. (не описываю все действия т.к. по аналогии)
	mov	edx, DWORD PTR -8[rbp]
	movsx	rdx, edx
	sal	rdx, 2
	lea	rcx, -4[rdx]
	mov	rdx, QWORD PTR -24[rbp]
	add	rdx, rcx
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR [rdx], eax
	#
	
	# Работа с памятью и выполнение строки кода ( arr[j] = temp;).
	mov	eax, DWORD PTR -8[rbp]  # Присваиваем eax элемент из A.
	lea	rdx, 0[0+rax*4]         # rdx = rax * 4.
	mov	rax, QWORD PTR -24[rbp]
	add	rdx, rax                # Приравниваем.
	mov	eax, DWORD PTR -12[rbp]
	mov	DWORD PTR [rdx], eax
	#
.L4:
	sub	DWORD PTR -8[rbp], 1          # Изменение значения.
.L3:
        # Проверка условия 2-ого цикла.
	mov	eax, DWORD PTR -8[rbp]        # eax = i
	cmp	eax, DWORD PTR -4[rbp]        # Если j > i, то переходим к вложенному циклу.
	jg	.L5
	# Если нарушено условие то выходим из вложенного цикла.
	add	DWORD PTR -4[rbp], 1          # ++i
.L2:
	mov	eax, DWORD PTR -28[rbp]       # Загрузка n из стека в регистр.
	sub	eax, 1                        
	cmp	DWORD PTR -4[rbp], eax        # Если i < (n - 1), то переходим к циклу.
	jl	.L6                           
	# Если нарушено условие, то выходим из функции.
	nop
	nop
	pop	rbp
	ret
.LC0:
	.string	"%d "                         # Экспортируем.
	.text                                 # Начало секции.                          
	.type	printArr, @function           # Отмечаем, что это функция.
printArr:                            
        # Пролог функции, выделяем 48 байт на стеке.
	push	rbp                           
	mov	rbp, rsp
	sub	rsp, 48
	
	# 4 - i
	# 24 - out
	# 32 - arr
	# 36 - n
	
	# Загрузка параметров в стек.
	mov	QWORD PTR -24[rbp], rdi       # out
	mov	QWORD PTR -32[rbp], rsi       # arr
	mov	DWORD PTR -36[rbp], edx       # n
	mov	DWORD PTR -4[rbp], 0          # i = 0
	jmp	.L8                           # Переход к метке L8 по коду(к условию цикла).
.L9:
	mov	eax, DWORD PTR -4[rbp]        # eax = i
	lea	rdx, 0[0+rax*4]               # rdx = rax * 4, сдвиг в памяти
	mov	rax, QWORD PTR -32[rbp]       # 3 агрумент arr[i]
	add	rax, rdx
	mov	edx, DWORD PTR [rax]
	mov	rax, QWORD PTR -24[rbp]       # 1 аргумент fprintf, output.txt
	lea	rcx, .LC0[rip]                # 2 аргумент fprtinf, "%d ".
	mov	rsi, rcx
	mov	rdi, rax                      
	mov	eax, 0                        # Обнуляем eax.
	call	fprintf@PLT                   # Вызываем fprintf.
	add	DWORD PTR -4[rbp], 1          # Увеличение i.
	# Переход к следующей итерации.
.L8:
	mov	eax, DWORD PTR -4[rbp]        # Загрузка n из стека в регистр.
	cmp	eax, DWORD PTR -36[rbp]       # Сравниваем i и n.
	jl	.L9                           # Если i < n, то переходим к циклу.
	
	# Если нарушено условие, то выходим из функции.
	nop
	nop
	leave
	ret
.LC1:
	.string	"%d"                          # Экспортируем.
	.text                                 # Начало секции.
	.type	fillArr, @function            # Отмечаем, что это функция.
fillArr:
	# Пролог функции, выделяем 48 байт на стеке.
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	
	# 4 - i
	# 24 - in
	# 32 - arr
	# 36 - n
	
	mov	QWORD PTR -24[rbp], rdi       # in
	mov	QWORD PTR -32[rbp], rsi       # arr
	mov	DWORD PTR -36[rbp], edx       # n
	mov	DWORD PTR -4[rbp], 0          # i = 0
	jmp	.L11                          # Переход к метке L11 по коду(к условию цикла).
.L12:
	mov	eax, DWORD PTR -4[rbp]        # eax = i
	lea	rdx, 0[0+rax*4]               # rdx = rax * 4, сдвиг в памяти
	mov	rax, QWORD PTR -32[rbp]       #	3 аргумент arr[i].
	add	rdx, rax
	mov	rax, QWORD PTR -24[rbp]       # 1 аргумент fscanf, "input.txt".
	lea	rcx, .LC1[rip]                # 2 аргумент fscanf, "%d ".
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0                        # Обнуляем eax.
	call	__isoc99_fscanf@PLT           # Вызов fscanf.
	add	DWORD PTR -4[rbp], 1          # увеличение i.
	# Переход к следующей итерации.
.L11:
	mov	eax, DWORD PTR -4[rbp]        # Загрузка n из стека в регистр.
	cmp	eax, DWORD PTR -36[rbp]       # Сравниваем i и n.
	jl	.L12                          # Если i < n, то переходим к циклу.
	
	# Если нарушено условие, то выходим из функции.
	nop
	nop
	leave
	ret
.LC2:
	.string	"r"                           # Загружаем "r".
.LC3:
	.string	"input.txt"                   # Загружаем "input.txt".
.LC4:
	.string	"w"                           # Загружаем "w".
.LC5:
	.string	"output.txt"                  # Загружаем "output.txt".
	.text                                 # Начало секции.
	.globl	main                          # Объявляем и экспортируем main.
	.type	main, @function               # Отмечаем, что это функция.
main:                   
	# Пролог функции, выделяем 848 байт на стеке.          
	push	rbp
	mov	rbp, rsp
	sub	rsp, 848
	
	lea	rax, .LC2[rip]                # Загружаем LC2("r") для fopen.
	mov	rsi, rax
	lea	rax, .LC3[rip]                # Загружаем LC3("input.txt") для fopen.
	mov	rdi, rax
	call	fopen@PLT                     # Вызываем fopen.
	mov	QWORD PTR -16[rbp], rax       # Заполняем in (in = fopen()).
	
	lea	rax, .LC4[rip]                # Загружаем LC4("w") для fopen.
	mov	rsi, rax
	lea	rax, .LC5[rip]                # Загружаем LC5("output.txt") для fopen.
	mov	rdi, rax
	call	fopen@PLT                     # Вызываем fopen.
	mov	QWORD PTR -24[rbp], rax       # Заполняем out (out = fopen()).
	
	lea	rdx, -836[rbp]                # Загружаем n для fscanf.
	mov	rax, QWORD PTR -16[rbp]       # Загружаем in для fscanf.
	lea	rcx, .LC1[rip]                # Загружаем LC1("%d") для fscanf.
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0                        # Обнуляем eax.
	call	__isoc99_fscanf@PLT           # Вызываем fscanf.
	mov	edx, DWORD PTR -836[rbp]      # Загружаем массив A для fillArr. 
	lea	rcx, -432[rbp]                # Загружаем n для fillArr.
	mov	rax, QWORD PTR -16[rbp]       # Загружаем in для fillArr.
	mov	rsi, rcx
	mov	rdi, rax
	call	fillArr                       # Вызываем filArr.
	mov	DWORD PTR -4[rbp], 0          # i = 0
	jmp	.L14                          # Переход к метке L14 по коду(к условию цикла).
.L15:
	mov	eax, DWORD PTR -4[rbp]          # eax = i
	
	# Операции с индексом и элементами массива.
	mov	edx, DWORD PTR -432[rbp+rax*4]
	mov	eax, DWORD PTR -4[rbp]
	mov	DWORD PTR -832[rbp+rax*4], edx
	add	DWORD PTR -4[rbp], 1            # Увеличение i
.L14:
	mov	eax, DWORD PTR -836[rbp]      # Загрузка массива из стека в регистр.
	cmp	DWORD PTR -4[rbp], eax        # Сравниваем i и n. 
	jl	.L15                          # Если  i < n, то переходим к L15(иначе выходим).
	mov	edx, DWORD PTR -836[rbp]      # Массив A для bubbleSort(1 аргумент).
	lea	rax, -832[rbp]                # n, для bubbleSort. (2 аргумент).
	mov	esi, edx
	mov	rdi, rax
	call	bubbleSort                    # Вызов функции bubbleSort.
	
	# Далее 3 строчки загружают out, n, B для printArr. 
	mov	edx, DWORD PTR -836[rbp]      # B 
	lea	rcx, -832[rbp]                # n
	mov	rax, QWORD PTR -24[rbp]       # in
	#
	mov	rsi, rcx
	mov	rdi, rax                      
	call	printArr                      # Вызов функции printArr.
	mov	eax, 0                        # Обнуляем eax.
	# Выходим.
	leave
	ret
