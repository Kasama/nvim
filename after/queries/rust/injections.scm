(
  (macro_invocation
    macro: [
      (scoped_identifier name: (_) @_macro_identifer)
      (identifier) @_macro_identifer
    ]
    (token_tree
      [
        (string_literal)
        (raw_string_literal)
      ] @sql
    )
  )
  (#match? @_macro_identifer "^query")
  (#offset! @sql 0 1 0 -1)
  (set! "priority" 105)
)
