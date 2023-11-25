.org    0x1000    // Start at memory location 1000
.text  // Code section
.global _start
_start:

MOV R0, #0 //return value
MOV R1, #10 //input 
MOV R2, #0
MOV R3, #0
STMFD sp!, {R0-R1} //push parameters
BL fib
LDMFD sp!, {R0-R1} // pop paramters

_stop:
b _stop

fib:
/*
-------------------------------------------------------
Calculates fibonacci number
-------------------------------------------------------
Parameters:
  R1 - input number
Uses:
  R0 - return value
  R2 - temporary variable
  R3 - temporary variable
-------------------------------------------------------
*/
STMFD sp!, {fp, lr}
MOV fp, sp
STMFD sp!, {R0-R3}

LDR R1, [fp, #12] //input number

//base case
CMP R1, #1
MOVLE R0, R1
BLE _fib

//decrease input by 1
SUB R1, R1, #1
STMFD sp!, {R0-R1}
BL fib
LDMFD sp!, {R0-R1}
MOV R2, R0

//decrease input by 2
SUB R1, R1, #1
STMFD sp!, {R0-R1}
BL fib
LDMFD sp!, {R0-R1}

MOV R3, R0
ADD R0, R2, R3

_fib:
STR R0, [fp, #8] //store result
LDMFD sp!, {R0-R3}
LDMFD sp!, {fp, pc}

.data
.end	