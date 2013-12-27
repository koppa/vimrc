" Vim syntax file
" Language:		Quartz
" Maintainer:	Matthias Schäfer (m_schae3@cs.uni-kl.de)
" Last Change:	20.10.2010
" Version:		1.9.9
" Filenames:	*.qrz

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

" Keywords
syn keyword	qLinker			package import macro
syn keyword	qModule			module satisfies observer drivenby
syn keyword	qStorage		event mem hybrid
syn keyword	qType			bv bool real nat int
syn keyword	qVerification	ProveE ProveA DisProveE DisProveA
syn keyword	qAction			emit next drv assume assert with constrainS constrainM constrainE constrainSM constrainSE constrainME constrainSME
syn keyword	qStatement		nothing pause flow
syn keyword	qConditional	if else weak final immediate when suspend abort let in for choose case default halt await
syn keyword	qRepeat			do while loop always each every during until
syn keyword	qConstant		instant inside terminate true false present absent
syn keyword qConversion		arr2bv tup2bv nat2bv int2bv bv2nat bv2int nat2int nat2real int2real
syn keyword	qLogOp			not eqv xor imp or and
syn keyword	qQuantifier		forall exists sum any
syn keyword	qNumericOp		abs sat
syn keyword	qBVOp			reverse @
syn keyword	qStaticOp		sin cos exp log sizeOf cont
syn keyword	qLinearTimeOp	X G F SU SB SW WU WB WW PG PF PSX PSU PSB PSW PWX PWU PWB PWW
syn keyword	qPathQuantifier	E A
syn keyword	qCalculus		fixpoint mu nu
syn keyword qMisc			time

" Numbers
syn match	qDecimal	display contained /[0-9][0-9]*/
syn match	qDual		display contained /0b[01]\+/
syn match	qOctal		display contained /0o[0-7]\+/
syn match	qHex		display contained /0x[0-9A-F]\+/
syn match	qReal		display contained /\(+|-\)\?[0-9]\+\.[0-9]\+\(e\(+|-\)\?[0-9]\+\)\?/
syn match	qNumbers	display transparent "\<\d\|\.\d" contains=qDecimal,qReal,qOctal,qDual,qHex

" Comments
syn keyword	qTodo		contained TODO FIXME XXX NOTE
syn match	qComment	"//.*" contains=qTodo
syn region	qComment	start="/\*" end="\*/"

" Labels
syn match	qLabel		/^[\s\t]*[a-zA-Z]([A-Z0-9a-z]*|_[a-zA-Z0-9]+)*[\s\t]*:/

" Links
hi def link qLinker			Structure
hi def link qModule			Structure
hi def link qStorage		StorageClass
hi def link qType			Type
hi def link qVerification	Debug
hi def link qAction			Operator
hi def link qStatement		Operator
hi def link qConditional	Conditional
hi def link qRepeat			Repeat
hi def link qConstant		Constant
hi def link qConversion		Type
hi def link qLogOp			Operator
hi def link qQuantifier		Repeat
hi def link qNumericOp		Operator
hi def link qBVOp			Operator
hi def link qStaticOp		Macro
hi def link qLinearTimeOp	Debug
hi def link qPathQuantifier	Debug
hi def link qCalculus		Operator
hi def link qMisc			Operator

hi def link qLabel			Label

hi def link qNumbers		Number

hi def link qComment		Comment
hi def link qTodo			Todo

hi def link qDecimal		qNumbers
hi def link qDual			qNumbers
hi def link qOctal			qNumbers
hi def link qHex			qNumbers
hi def link qReal			Float

let b:current_syntax = "qrz"
