.text
.globl _start

min = 0 	/*starting value for the loop*/
max = 30	/*ending value for the loop  */

_start:

	mov	x19, min	/* loop counter */

loop:
// Preparing message
	mov	x9, 10		/* register used for the division */
	udiv	x18,x19,x9	/* divide counter to obtain first decimal*/
	add	x18, x18, '0'	/* add character 0 plus iter value */
	adr	x17, msg+6	/* msg+6 position, first # */
	cmp	x19, 9
	b.gt	greater
	mov	x15, ' '
	strb	w15, [x17]	
	b	loop2
greater:
	strb	w18, [x17]	/* store one byte from r18 into r17 */
	b	loop2
 
loop2:	msub	x16,x9,x18,x19	/* reminder r3-(r1*r2) -> x19 - (x9*x18) */
	add	x16, x16, 0x10  /* +0x10 because x18 already has +'0'  */
	adr	x17, msg+7	/* second #  */
	strb	w16, [x17]	/* store one byte from r16 into address */

	mov     x0, 1           /* file descriptor: 1 is stdout */
	adr     x1, msg   	/* message location (memory address) */
	mov     x2, len   	/* message length (bytes) */

	mov     x8, 64     	/* write is syscall #64 */
	svc     0          	/* invoke syscall */
 
	add 	x19, x19, 1	/* add one to the loop counter */
	cmp	x19, max	/* did I reach the end of the loop */
	b.ne	loop		/* if not, loop again */

	mov     x0, 0     	/* status -> 0 */
	mov     x8, 93    	/* exit is syscall #93 */
	svc     0          	/* invoke syscall */

.data
msg: 	.ascii      "Loop: ##\n"
len= 	. - msg

