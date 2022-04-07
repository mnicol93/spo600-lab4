/* 
   This is a 'hello world' program in x86_64 assembler using the 
   GNU assembler (gas) syntax. Note that this program runs in 64-bit
   mode.

   CTyler, Seneca College, 2014-01-20
   Licensed under GNU GPL v2+
*/

.text
.globl	_start

min = 0 	/* start of the loop */
max = 30	/* end of the loop */

_start:

print:	mov	$min,%r15

loop:	mov	%r15,%r14
	add	$'0',%r14
	movb	%r14b,msg+7	/* mov the one byte of r14 into the address msg+7 */

	movq	$len,%rdx	/* message length */
	movq 	$msg,%rsi	/* message location */
	movq	$1,%rdi		/* file descriptor stdout */
	movq	$1,%rax		/* syscall sys_write */
	syscall
	
	inc	%r15
	cmp	$max,%r15
	jne 	loop

	movq	$0,%rdi		/* exit status */
	movq	$60,%rax	/* syscall sys_exit */
	syscall

.section .data

msg:	.ascii      "Loop: ##\n"
	len = . - msg


