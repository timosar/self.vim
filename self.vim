" Vim syntax file
" Language:   Self (prototype-based, Smalltalk-like)
" Filenames:  *.self
"
" Installation:
"   ~/.vim/syntax/self.vim        (this file)
"   ~/.vim/ftdetect/self.vim      containing:
"       autocmd BufRead,BufNewFile *.self setfiletype self
"   (Neovim: ~/.config/nvim/syntax/ and ~/.config/nvim/ftdetect/)

if exists("b:current_syntax")
  finish
endif

syn case match

" ---------------------------------------------------------------------------
" Comments: "double quoted", may span multiple lines
" ---------------------------------------------------------------------------
syn keyword selfTodo contained TODO FIXME XXX NOTE
syn region  selfComment start=/"/ end=/"/ contains=selfTodo,@Spell

" ---------------------------------------------------------------------------
" Strings: 'single quoted', with backslash escapes
" ---------------------------------------------------------------------------
syn match  selfEscape contained /\\\([abfnrtv0\\'"?]\|x\x\x\|\o\{1,3\}\)/
syn region selfString start=/'/ skip=/\\./ end=/'/ contains=selfEscape,@Spell

" ---------------------------------------------------------------------------
" Numbers
" ---------------------------------------------------------------------------
syn match selfNumber /\<\d\+\>/
syn match selfNumber /\<\d\+r\w\+\>/
syn match selfNumber /\<0[xX]\x\+\>/
syn match selfFloat  /\<\d\+\.\d\+\([eE][-+]\?\d\+\)\?\>/
syn match selfFloat  /\<\d\+[eE][-+]\?\d\+\>/

" ---------------------------------------------------------------------------
" Punctuation, delimiters, operators
" ---------------------------------------------------------------------------
syn match selfOperator   /[-+*\/<>=~!@#$%&?,\\^]\+/
syn match selfTerminator /\./
syn match selfBar        /|/
syn match selfDelimiter  /[\[\]()]/
syn match selfObjDelim   /(|\||)/

" ---------------------------------------------------------------------------
" Identifiers / messages
" ---------------------------------------------------------------------------
" Keyword message parts:  at:  Put:  ifTrue:  do:
syn match selfKeyword    /\<\h\w*:/

" Block arguments:  :i
syn match selfBlockArg   /:\h\w*/

" Slot definitions:  name = ...   name <- ...
syn match selfSlotDef    /\<\h\w*\ze\s*\(<-\|=\)/

" Parent slots:  parent* = ...   parentWalker* = ...
syn match selfParentSlot /\<\h\w*\*/

" ---------------------------------------------------------------------------
" Control flow / boolean messages
" ---------------------------------------------------------------------------
syn match selfControl /\<\(ifTrue\|ifFalse\|whileTrue\|whileFalse\|and\|or\|if\|do\|to\|by\|from\|upTo\|downTo\|doWithKey\|reverseDo\|ifNil\|ifNotNil\|loop\|repeat\):/
syn match selfControl /\<\(whileTrue\|whileFalse\|loop\|repeat\)\>/
syn match selfControl /\<\(True\|False\|Do\|Put\|Else\|Then\):/

" ---------------------------------------------------------------------------
" Special / pseudo variables
" ---------------------------------------------------------------------------
syn keyword selfConstant true false nil
syn keyword selfSpecial  self super
syn match   selfResend   /\<\(resend\|super\|self\)\.\h\w*/
syn keyword selfResendKw resend

" ---------------------------------------------------------------------------
" Common builtins / well-known objects
" ---------------------------------------------------------------------------
syn keyword selfBuiltin  printLine print printString value copy clone size
syn keyword selfBuiltin  isEmpty first last removeAll reverse
syn keyword selfObject   list dict vector string lobby traits mirror reflect
syn keyword selfObject   object

" ---------------------------------------------------------------------------
" Highlight links
" ---------------------------------------------------------------------------
hi def link selfComment    Comment
hi def link selfTodo       Todo
hi def link selfString     String
hi def link selfEscape     SpecialChar
hi def link selfNumber     Number
hi def link selfFloat      Float
hi def link selfOperator   Operator
hi def link selfTerminator Delimiter
hi def link selfBar        Delimiter
hi def link selfDelimiter  Delimiter
hi def link selfObjDelim   Special
hi def link selfKeyword    Function
hi def link selfBlockArg   Identifier
hi def link selfSlotDef    Type
hi def link selfParentSlot StorageClass
hi def link selfControl    Conditional
hi def link selfConstant   Constant
hi def link selfSpecial    Special
hi def link selfResend     Statement
hi def link selfResendKw   Statement
hi def link selfBuiltin    Function
hi def link selfObject     Structure

let b:current_syntax = "self"
