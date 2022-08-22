    .data

inputId : .asciz "*****Input Id*****\n"
enterId : .asciz "** Please Enter Member %d ID:**\n"
enterCommand : .asciz "** Please Enter Command **\n"
printid : .asciz "****Print Team Member ID and ID Summation*****\n%d\n%d\n%d\n\n"
sum : .word 0
idSummation: .asciz "ID Summation: %d\n"
num : .asciz "%d"
ID : .word 0
id1: .word 0
id2: .word 0
id3: .word 0
aChar : .asciz "%c"
command : .word 0
endPrint : .asciz "******End Print*****\n\n"

    .text
    .globl id

id:
      stmfd sp!,{r4-r10,lr}     @ push lr to the stack
      sub sp,sp,#16
      mov r5,sp
      str r0,[r5]  @ the first argument, &id1
      str r1,[r5,#4] @ the second argument, &id2
      str r2,[r5,#8] @ the third argument,&id3
      str r3,[r5,#12] @ forth argument,&idSum

      ldr r0,=inputId
      bl printf
      mov r4,#1          @ i
      ldr r6,=id1      @ the address of id1
readId:
       cmp r4,#4
       beq idAndSum  @ if r4==4 then branch to the label 'idAndSum'
       ldr r0, =enterId
       mov r1,r4
       bl printf       @print "** Please Enter Member i ID:**"
       ldr r0,=num
       ldr r1,= ID
       bl scanf       @ read Id
       ldr r1,=ID   @ load address of ID
       ldr r1,[r1]  @ load value of ID
       str r1,[r6],#4 @ store the word in r1 at the address in r5 then increment r5 by 4
       add r4,r4,#1   @ r4 =r4+1  i=i+1
       b readId     @ Go back to top of readId

idAndSum:

      ldr r6,=id1   @ the start address of idarr
      ldr r7,[r6]     @ load r1 with word at the address in r0
      ldr r8,[r6,#4]! @ load r2 with word at the address (r0+4),then store the address in r0
      ldr r9,[r6,#4]  @ load r3 with word at the address (r0+4)
      cmp r1,r2       @ compare r1 and r2
      bne else        @ if (r1 != r2 ) then branch to the label 'else'
      cmpeq r8,r9     @if ( r1==r2 ) then compare r2 and r3
      addeq r10,r7,r7,asl #1   @ if (r1 == r2 == r3 ) then r7=r1+r1*2=r1*3
      addlt r10,r9,r7,asl #1   @ if (r1 == r2 && r2 < r3 ) then r7=r3+r2*2
      addgt r10,r9,r7,asl #1   @ if (r1 == r2 && r2 > r3 ) then r7=r3+r2*2
      b readCommand    @ branch to the label 'readCommand'

else:                 @ r1 != r2

      add r10,r7,r8    @ r7=r1+r2
      add r10,r10,r9    @ r7=r7+r3
      b readCommand   @ branch to the label 'readCommand'


readCommand:

      ldr r6,=sum
      str r10,[r6]

      ldr r0,=aChar
      ldr r1,=command
      bl scanf  @ read enter

      ldr r0,=enterCommand
      bl printf    @ print"** Please Enter Command **\n"
      ldr r0,=aChar @ %c
      ldr r1,=command
      bl scanf  @ scan command

      ldr r6,=command  @ load the address of command
      ldr r6,[r6]      @ load the value of command
      cmp r6,#112  @compare r1 and p
      cmpne r6,#80  @ if r1!='p' then compare r1 and 'P'
      beq printIdAndSum  @ if r1=='p' or 'P' then branch to the label 'idandSum'
      bne end       @ if (r1!='p' && r1!='P') then branch to the label 'end'

printIdAndSum:

      ldr r0,=printid
      ldr r6,=id1  @ load the address of idarr
      ldr r1,[r6]
      ldr r2,[r6,#4] @ load second argument,load r2 with word at the address (r1+4)
      ldr r3,[r6,#8] @ load third argument,load r2 with word at the address (r1+8)
      bl printf

      ldr r0,=idSummation
      ldr r1,=sum  @ r1 is the address of sum
      ldr r1,[r1]  @ load r1 with a word at the address in r1
      bl printf

      ldr r0,=endPrint
      bl printf
      b end

end:

       mov r5,sp
       ldr r0,[r5]    @r0 = &id1
       ldr r1,[r5,#4] @r1 = &id2
       ldr r2,[r5,#8] @r2 = &id3
       ldr r3,[r5,#12]

       ldr r6,=id1
       ldr r6,[r6]
       str r6,[r0]

       ldr r6,=id2
       ldr r6,[r6]
       str r6,[r1]

       ldr r6,=id3
       ldr r6,[r6]
       str r6,[r2]

       ldr r6,=sum
       ldr r6,[r6]
       str r6,[r3]


       add sp,sp,#16
       ldmfd sp!,{r4-r10,lr}
       mov pc,lr



