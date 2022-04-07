.text
.globl _start

min = 0 	/*starting value for the loop*/
max = 30	/*ending value for the loop  */

_start:

	mov	x19, min	/* loop counter */

loop:
// Preparing message
	add	x18, x19, '0'	/* add character 0 plus iter value */
	adr	x17, msg+7	/* msg+6 position of first # */
	strb	w18, [x17]	/* store one byte from r18 into r17 */
 
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
msg: 	.ascii      "Loop: #\n"
len= 	. - msg

