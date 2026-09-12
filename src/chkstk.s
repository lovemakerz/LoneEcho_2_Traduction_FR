.text
.globl __chkstk
.def __chkstk; .scl 2; .type 32; .endef
__chkstk:
    movq %rax, %r11
    movq %rsp, %r10
    cmpq $0x1000, %r11
    jb 2f
1:
    subq $0x1000, %r10
    testb $0, (%r10)
    subq $0x1000, %r11
    cmpq $0x1000, %r11
    jae 1b
2:
    subq %r11, %r10
    testb $0, (%r10)
    retq
