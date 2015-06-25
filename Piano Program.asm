INCLUDE Irvine32.inc

Wstring macro offest 
push edx
mov edx , offest
call writestring 
call crlf
pop edx
endm

.data
ESCP byte 1bh 
Duration equ 500
replay byte 100 dup(?)
error byte "You didnot enter any note !!",0
wec1 byte "      Welcome to Piano Program" ,0
wec2 byte "Press 1: To replay the note you entered",0
wec3 byte "Press Esc: To exit" ,0
wec4 byte "      You are now free to play Piano",0
end0 byte "                 Good buy ^_^ ",0
end1 byte "        _                       ____",0
end2 byte "       ( )                     |____|",0
end3 byte "    ___|/________|\____________|____|_______",0
end4 byte "   |__/|/_)_|____|_______|\__(_)__(_)_______|",0
end5 byte "   |_(_|_/__|__(_)_______|\_________________|",0
end6 byte "   |___|____|__________(_)__________________|",0
end7 byte "   |________|_________________________(_)___|",0
end8 byte "                                        |",0
end9 byte "                                        |",0

.code

Sound proto char : byte
Beep proto Frequency : Dword, Duration : Dword 
Sleep PROTO dwMilliseconds:DWORD


main PROC
	call Welcome

	mov ecx ,0
	mov edi , offset replay
	.while 1
	  call readchar

	  .if al == '1'
		 .if ecx != 0
			 push ecx
			 invoke sleep , 300
			 pop ecx
			 mov esi , offset replay
			 l1:
				lodsb 
				invoke Sound, al
				push ecx
				invoke sleep , 100
				pop ecx
			loop l1
			mov edi , offset replay
		 .else
			Wstring offset error
		 .endif
	 .elseif al == ESCP 
	   je Exti 
	 .else
	 ; count & save # note
		stosb
		inc ecx 
		invoke Sound, al
	  .endif

	.endw

	Exti:
	  call Ennd
	exit
main ENDP

; Function 
Sound proc char : byte
push ecx
;Do ---> q a z 
 ;Re ---> w s x 
 ;Me ---> e d c 
 ;Fa ---> r f v 
 ;SOL---> t g b 
 ;La ---> y h n 
 ;Ce ---> u j m 
	; low 131 , 147 , 165 , 175 , 196 , 220 , 247
	.if al == 'q' 
	   invoke Beep , 131, Duration
	.elseif al == 'w' 
	   invoke Beep , 147, Duration
	.elseif al == 'e' 
	   invoke Beep , 165, Duration
	.elseif al == 'r' 
	   invoke Beep , 175, Duration
	.elseif al == 't' 
	   invoke Beep , 196, Duration
	.elseif al == 'y' 
	   invoke Beep , 220, Duration
	.elseif al == 'u' 
	   invoke Beep , 247, Duration
	; med 262 , 294 , 330 , 349 , 392 , 440 , 494
	.elseif al == 'a' 
	   invoke Beep , 262, Duration
	.elseif al == 's' 
	   invoke Beep , 294, Duration
	.elseif al == 'd' 
	   invoke Beep , 330, Duration
	.elseif al == 'f' 
	   invoke Beep , 349, Duration
	.elseif al == 'g' 
	   invoke Beep , 392, Duration
	.elseif al == 'h' 
	   invoke Beep , 440, Duration
	.elseif al == 'j' 
	   invoke Beep , 494, Duration
	   ; high 523 , 587 , 659 , 698 , 784 , 880 , 988
	.elseif al == 'z' 
	   invoke Beep , 523, Duration
	.elseif al == 'x' 
	   invoke Beep , 587, Duration
	.elseif al == 'c' 
	   invoke Beep , 659, Duration
	.elseif al == 'v' 
	   invoke Beep , 698, Duration
	.elseif al == 'b' 
	   invoke Beep , 784, Duration
	.elseif al == 'n' 
	   invoke Beep , 880, Duration
	.elseif al == 'm' 
	   invoke Beep , 988, Duration
	.endif

pop ecx
ret
Sound endp

Welcome proc 
   Wstring offset wec1
   Wstring offset wec2
   Wstring offset wec3
   Wstring offset wec4
ret
Welcome endp

Ennd proc
    Wstring offset end0
	Wstring offset end1
	Wstring offset end2
	Wstring offset end3
	Wstring offset end4
	Wstring offset end5
	Wstring offset end6
	Wstring offset end7
	Wstring offset end8
	Wstring offset end9
ret
Ennd endp

END main