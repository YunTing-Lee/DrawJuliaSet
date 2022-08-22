   .data

function1 : .asciz "Function1 : Name\n"
PrintName: .asciz "******Print Name*****\n"
Team : .asciz "Team %d\n"
teamId : .word 54
Name : .asciz "%s\n%s\n%s\n"
name1 : .asciz "Ariel Tsai 1"
name2 : .asciz "Diana Lee"
name3 : .asciz "Ariel Tsai 2"
endPrint : .asciz "******End Print*****\n\n"

    .text
    .globl name

name:
       stmfd sp!,{r4,r5,lr}    @ push lr to the stack

       sub sp,sp,#64
       mov r5,sp
       str r0,[r5] @ first argument, name1[20]
       str r1,[r5,#20] @second argument, name2[20]
       str r2,[r5,#40] @third argument,name3[20]
       str r3,[r5,#60] @fourth argument,teamId

       mov r1,r13
       mov r2,r14
       mov r13,#0
       mov r14,r15
       adds r15,r14,r13
       mov r13,r1
       mov r14,r2


       ldr r0, =PrintName
       bl printf

       ldr r0, = Team
       ldr r1,=teamId
       ldr r1,[r1]
       bl printf


       ldr r0,=Name
       ldr r1, = name1   @ load first argument, load address of name1 string
       ldr r2, = name2   @ load second argument,load address of name2 string
       ldr r3, = name3   @ load third argument, load address of name3 string
       bl printf

       ldr r0, = endPrint
       bl printf


       ldr r0,[r5]     @r0= name1
       ldr r1,=name1   @r1 = "Ariel Tsai 1"
       bl strcpy       @strcpy(name1,"Ariel Tsai 1")

       ldr r0,[r5,#20] @r0=name2
       ldr r1,=name2   @r1 = "Diana Lee"
       bl strcpy       @strcpy(name2,"Diana Lee")

       ldr r0,[r5,#40] @r0=name3
       ldr r1,=name3   @r1 = "Ariel Tsai 2"
       bl strcpy       @strcpy(name3,"Ariel Tsai 1")

       ldr r3,[r5,#60] @r3 = &teamId
       ldr r4,=teamId
       ldr r4,[r4]     @r4=54
       str r4,[r3]     @store 54 in &teamId

       add sp,sp,#64
       ldmfd sp!,{r4,r5,lr}
       mov pc,lr




