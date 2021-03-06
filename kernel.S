 
.syntax unified
.cpu cortex-m4
//.fpu softvfp
.thumb

#define A #5
#define B #2
#define C #3

// Global memory locations.
.global vtable_kernel
.global __kernel_reset__

.type vtable_kernel, %object
.type __kernel_reset__, %function

.section .interrupt_vector

vtable_kernel:
	.word __stack_start
	.word __kernel_reset__+1
	.size vtable_kernel, .-vtable_kernel

.section .rodata

	data: .asciz "kernel started!\n"
	final: .asciz "Result value in register #4: "
    
.section .text

__kernel_reset__:
	ldr r0, =data
	bl dbgput_line

// calculate
   	mov r0, A
    	mov r1, B
    	mov r2, C
    	mov r3, r0
    	mov r4, r0
    	mul r3, r1
    	cmp r3, #10
    	ITE GE
    	ORRGE r4, r1
    	ANDLT r4, r1
    	MUL r4, r2

	ldr r0, =final
	bl dbgput
	mov r0, r4
	bl dbgput_num    

end:
	b end
