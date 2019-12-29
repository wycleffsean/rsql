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
  period
  integer
  string

rule
  statement:
    query semicolon { result = [val[0]] }
  query:
      select_query
    | create_table_query
    | insert_into_query
  create_table_query: kw_create kw_table relation lparen column_definitions rparen { result = [:create_table, val[2].merge(columns: val[4]) ] }
  column_definitions:
      column_definition { result = val }
    | column_definitions comma column_definition { result = val[0] << val[2] }
  column_definition: symbol symbol { result = [val[0], val[1]] }
  insert_into_query: kw_insert kw_into relation insert_columns insert_data { result = [:insert_into_query, val.values_at(2, 3, 4).compact.reduce(&:merge)] }
  insert_columns: { {} }
    | lparen symbol_collection rparen { result = { column_names: val[1] } }
  insert_data:
      select_query { result = Hash[val] }
    | kw_values values_collection { result = { rows: val[1] } }
  values_collection:
    | values { result = val }
    | values_collection comma values { result = val[0] + [val[2]] }
  values:  lparen literal_collection rparen { result = val[1] }
  select_query: select_stmt from_stmt where_stmt { result = [:select_query, val.values_at(1, 2, 0).compact] }
  select_stmt: kw_select collection { result = [:select, val[1]]  }
  from_stmt:
    kw_from relation { result = [:from, val[1]] }
  relation:
    symbol period symbol { result = { schema_name: val[0], table_name: val[2] } }
    | symbol { result = { table_name: val[0].to_sym } }
  where_stmt: | kw_where predicate { result = [:where, val[1]] }
  predicate:
    atom binary_operator atom { result = [val[1], [ val[0], val[2] ]] }
    | predicate binary_operator predicate { result = [val[1], [ val[0], val[2] ]] }
    | lparen predicate rparen { result = val[1] }
  binary_operator:
    op_equal { result = :'==' }
    | op_or { result = :or }
    | op_and { result = :and }
    | op_lt { result = :< }
    | op_lte { result = :<= }
    | op_gt { result = :> }
    | op_gte { result = :>= }
  collection:
    | atom { result = val }
    | collection comma atom { result = val[0] << val[2] }
  symbol_collection:
    | symbol { result = val }
    | symbol_collection comma symbol { result = val[0] << val[2] }
  literal_collection:
    | literal { result = val }
    | literal_collection comma literal { result = val[0] << val[2] }
  atom:
      star { result = val[0].to_sym }
    | symbol
    | literal
  literal:
      integer
    | string
  symbol: identifier { result = val[0].downcase.to_sym }
end
