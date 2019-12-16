class Rsql::Parser
token kw_select kw_from kw_where kw_null kw_not kw_insert kw_into
  kw_values kw_create kw_table kw_constraint kw_key kw_primary
  star lparen rparen ws op_or op_and identifier op_equal semicolon
  comma integer string

rule
  statement: query
  query: select_stmt from_stmt where_stmt semicolon { result = val[0..-2] }
  select_stmt: kw_select collection { result = [:select, val[1]]  }
  from_stmt:
    kw_from identifier { result = [:from, val[1]] }
  where_stmt: kw_where predicate { result = [:where, val[1]] }
  predicate:
    identifier binary_operator identifier { result = [val[1], [ val[0], val[2] ]] }
    | predicate binary_operator predicate { result = [val[1], [ val[0], val[2] ]] }
    | lparen predicate rparen { result = val[1] }
  binary_operator:
    op_equal { result = :'=' }
    |op_or { result = :or }
    | op_and { result = :and }
  collection:
    | atom
    | collection ',' atom { result = val[0] << val[2] }
  atom: star | identifier
end
