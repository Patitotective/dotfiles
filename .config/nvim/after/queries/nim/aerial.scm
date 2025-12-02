;; extends

; TODO: add support for runnableExamples? and task (nimble)

(import_statement
  (expression_list) @name @symbol
  (#set! "kind" "Package"))

(include_statement
  (expression_list) @name @symbol
  (#set! "kind" "Package"))

(type_declaration
  (type_symbol_declaration
    name: (_) @name
  ) @symbol
  (#set! "kind" "Class"))

; TODO: match parameters more precisely to allow spaces in the apporpiate places (after a colon or a comma) and remove all other spaces
((proc_declaration) @name @symbol
  (#gsub! @name "proc%s+(.-%b()).-=.*" "%1") ; To show everything before the =
  (#gsub! @name "proc%s+(.-%b())[^=]*" "%1") ; To match declarations that do not implement the body
  (#gsub! @name "%s+" " ") ; To try to pretty declarations that spand multiple lines
  (#set! "kind" "Function"))

((template_declaration) @name @symbol
  (#gsub! @name "template%s+(.-%b()).-=.*" "%1") ; To show everything before the =
  (#gsub! @name "template%s+(.-%b())[^=]*" "%1") ; To match declarations that do not implement the body
  (#gsub! @name "%s+" " ") ; To try to pretty declarations that spand multiple lines
  (#set! "kind" "Constructor"))

((macro_declaration) @name @symbol
  (#gsub! @name "macro%s+(.-%b()).-=.*" "%1") ; To show everything before the =
  (#gsub! @name "macro%s+(.-%b())[^=]*" "%1") ; To match declarations that do not implement the body
  (#gsub! @name "%s+" " ") ; To try to pretty declarations that spand multiple lines
  (#set! "kind" "Constructor"))

((when
  condition: (_) @name
  ) @symbol
  (#gsub! @name "^" "when ")
  (#set! "kind" "Boolean"))

((if
  condition: (_) @name
  ) @symbol
  (#gsub! @name "^" "if ")
  (#set! "kind" "Boolean"))

((for) @name @symbol
  (#gsub! @name "(for%s+.-%s+in%s+.-):.*" "%1") ; To show everything before the :
  (#set! "kind" "Boolean"))

((while
  condition: (_) @name
  ) @symbol
  (#gsub! @name "^" "while ") ; To show everything before the :
  (#set! "kind" "Boolean"))


(if
  alternative: (elif_branch
    condition: (_) @name
  ) @symbol
  (#gsub! @name "^" "elif ")
  (#set! "kind" "Boolean"))

(if
  alternative: (else_branch) @name @symbol
  (#set! @name "text" "else")
  (#set! "kind" "Boolean"))

((case
   value: (_) @name
   (#gsub! @name "^" "case ")
   ) @symbol
 (#set! "kind" "Enum"))

(case
  (of_branch
    values: (_) @name
    ) @symbol
  (#set! "kind" "EnumMember")
  (#gsub! @name "^" "of "))

(case
  (else_branch) @symbol @name
  (#set! "kind" "EnumMember")
  (#set! @name "text" "else"))

((block) @name @symbol
  (#gsub! @name "(block%s*.-):.*" "%1") ; To show everything before the :
  (#set! "kind" "Boolean"))

; (const_section
;   (variable_declaration
;     (symbol_declaration_list
;       (symbol_declaration
;         name: (_) @name)
;       )
;     ) @symbol
;   (#set! "kind" "Constant")
; )
;
; (let_section
;   (variable_declaration
;     (symbol_declaration_list
;       (symbol_declaration
;         name: (_) @name
;         )
;       )
;     ) @symbol
;   (#set! "kind" "Variable")
; )
;
; (var_section
;   (variable_declaration
;     (symbol_declaration_list
;       (symbol_declaration
;         name: (_) @name
;         )
;       )
;     ) @symbol
;   (#set! "kind" "Variable")
;  )

