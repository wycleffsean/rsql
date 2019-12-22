class Rsql::Parser
token
  kw_select
  kw_from
  kw_where
  kw_null
  kw_not
  kw_insert
  kw_into
  kw_values
  kw_create
  kw_table
  kw_constraint
  kw_key
  kw_primary
  star
  lparen
  rparen
  ws
  op_or
  op_and
  op_lt
  op_gt
  op_gte
  op_lte
  identifier
  op_equal
  semicolon
  comma
  integer
  string

rule
  statement: query
  query: select_stmt from_stmt where_stmt semicolon { result = [:query, [val[1], val[2], val[0]]] }
  select_stmt: kw_select collection { result = [:select, val[1]]  }
  from_stmt:
    kw_from identifier { result = [:from, val[1].to_sym] }
  where_stmt: kw_where predicate { result = [:where, val[1]] }
  predicate:
    atom binary_operator atom { result = [val[1], [ val[0], val[2] ]] }
    | predicate binary_operator predicate { result = [val[1], [ val[0], val[2] ]] }
    | lparen predicate rparen { result = val[1] }
  binary_operator:
    op_equal { result = :'==' }
    | op_or { result = :or }
    | op_and { result = :and }
    | op_lt { result = :< }
    | op_gt { result = :> }
    | op_gte { result = :<= }
    | op_lte { result = :>= }
  collection:
    | atom { result = val }
    | collection comma atom { result = val[0] << val[2] }
  atom:
    star { result = val[0].to_sym }
    | identifier { result = val[0].to_sym }
    | integer
end
