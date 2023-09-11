syn clear

syn keyword rvI addi xori ori andi slli srli sari slti jalr
syn keyword rvb beq bne blt bge bltu bgeu
syn keyword rvS ecall
syn keyword rvILoad lb lh lw lbu lhu
syn keyword rvJ jal
syn keyword rvR add sub xor or and sll srl sra slt sltu
syn keyword rvRM mul mulh mulhsu mulhu div divu rem remu
syn keyword rvS sb sh sw
syn keyword rvu lui auipc

syn keyword rvITR mv not neg seqz snez sltz sgtz
syn keyword rvRO beqz bnez blez bgez bltz bgtz
syn keyword rvPseudo nop li la j jal jr jalr ret call tail

syn region rvComment start="#" end="\$"

syn match rvReg "\<x\(\([0-2]\?[0-9]\?\)\|\(3[0-1]\)\)\>"

if !exists("did_rv_syntax_init")
    let did_rv_syntax_init = 1

endif
