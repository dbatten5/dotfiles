; extends

(function_definition
  parameters: (parameters)
  return_type: (type) @return_type)

((function_definition
   "->" @_start
   .
   return_type: (type) @return_type)
   (#make-range! "return_type.outer" @_start @return_type))

[(import_statement) (import_from_statement)] @import_statement
