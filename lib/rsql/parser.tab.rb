#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.4.16
# from Racc grammar file "".
#

require 'racc/parser.rb'
module Rsql
  class Parser < Racc::Parser
##### State transition tables begin ###

racc_action_table = [
    18,    38,    18,    29,    18,    38,     9,    21,    22,    23,
    23,    18,    23,    46,    23,    21,    22,    21,    22,    21,
    22,    23,    18,    38,    18,    76,    21,    22,    21,    22,
    59,    65,    23,    23,    23,    23,    77,    21,    22,    21,
    22,    60,    66,    69,    23,    51,    52,    53,    55,    56,
    54,     9,    50,    64,    10,    23,     7,    24,    23,     6,
    51,    52,    53,    55,    56,    54,    64,    50,    51,    52,
    53,    55,    56,    54,    15,    50,    51,    52,    53,    55,
    56,    54,    13,    50,    12,    11,    23,    71,    23,    31,
    32,    35,    33,    23 ]

racc_action_check = [
    29,    29,    57,    14,    49,    49,    34,    77,    77,    32,
    29,     9,    57,    34,    49,    29,    29,    57,    57,    49,
    49,     9,    38,    38,    31,    72,     9,     9,    64,    64,
    40,    47,    38,    33,    31,    13,    72,    38,    38,    31,
    31,    40,    47,    58,    35,    58,    58,    58,    58,    58,
    58,     0,    58,    71,     1,    12,     0,    10,    42,     0,
    36,    36,    36,    36,    36,    36,    46,    36,    37,    37,
    37,    37,    37,    37,     8,    37,    67,    67,    67,    67,
    67,    67,     7,    67,     6,     2,    60,    62,    66,    16,
    25,    27,    26,    15 ]

racc_action_pointer = [
    49,    54,    58,   nil,   nil,   nil,    73,    74,    71,    -4,
    57,   nil,    30,    10,    -1,    68,    61,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,    74,    63,    75,   nil,   -15,
   nil,     9,   -16,     8,     4,    19,    41,    49,     7,   nil,
    13,   nil,    33,   nil,   nil,   nil,    50,    14,   nil,   -11,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   -13,    26,   nil,
    61,   nil,    59,   nil,    -2,   nil,    63,    57,   nil,   nil,
   nil,    37,     8,   nil,   nil,   nil,   nil,   -23,   nil ]

racc_action_default = [
   -49,   -49,   -49,    -2,    -3,    -4,   -49,   -49,   -49,   -34,
   -49,    -1,   -49,   -49,   -49,   -49,   -19,   -35,   -43,   -44,
   -45,   -46,   -47,   -48,    79,   -49,   -22,   -10,   -18,   -49,
   -20,   -49,   -49,   -49,   -49,   -37,   -23,   -49,   -49,   -36,
   -49,    -6,   -49,   -21,    -9,   -12,   -14,   -49,   -38,   -49,
   -27,   -28,   -29,   -30,   -31,   -32,   -33,   -49,   -49,    -5,
   -49,    -8,   -13,   -15,   -40,   -11,   -49,   -25,   -24,   -26,
    -7,   -49,   -49,   -41,   -39,   -16,   -17,   -49,   -42 ]

racc_goto_table = [
    26,    26,    17,    26,     3,    41,    63,    36,    62,    73,
    25,    27,    72,    30,    14,    28,    58,    16,    57,    47,
    42,    43,    78,    48,    39,     2,     4,    67,     5,    40,
    61,    75,    34,    70,    44,     1,   nil,   nil,    45,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,    42,   nil,
    68,   nil,   nil,   nil,    74 ]

racc_goto_check = [
     9,     9,    21,     9,     3,     8,    14,    20,    13,    23,
     6,     6,    15,     6,    17,    18,    20,    19,    22,    12,
     9,     9,    23,     9,    21,     2,     4,    20,     5,     7,
     9,    14,    10,     8,    11,     1,   nil,   nil,     3,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,     9,   nil,
    21,   nil,   nil,   nil,     9 ]

racc_goto_pointer = [
   nil,    35,    25,     4,    26,    28,    -2,    -3,   -27,   -12,
     5,     0,   -16,   -38,   -40,   -52,   nil,     6,     1,     8,
   -22,    -7,   -19,   -55 ]

racc_goto_default = [
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,    19,
   nil,   nil,   nil,   nil,   nil,   nil,     8,   nil,   nil,   nil,
   nil,    37,    49,    20 ]

racc_reduce_table = [
  0, 0, :racc_error,
  2, 33, :_reduce_1,
  1, 34, :_reduce_none,
  1, 34, :_reduce_none,
  1, 34, :_reduce_none,
  6, 36, :_reduce_5,
  1, 39, :_reduce_6,
  3, 39, :_reduce_7,
  2, 40, :_reduce_8,
  5, 37, :_reduce_9,
  0, 42, :_reduce_10,
  3, 42, :_reduce_11,
  1, 43, :_reduce_12,
  2, 43, :_reduce_13,
  0, 45, :_reduce_none,
  1, 45, :_reduce_15,
  3, 45, :_reduce_16,
  3, 46, :_reduce_17,
  3, 35, :_reduce_18,
  2, 48, :_reduce_19,
  2, 49, :_reduce_20,
  3, 38, :_reduce_21,
  1, 38, :_reduce_22,
  2, 50, :_reduce_23,
  3, 52, :_reduce_24,
  3, 52, :_reduce_25,
  3, 52, :_reduce_26,
  1, 54, :_reduce_27,
  1, 54, :_reduce_28,
  1, 54, :_reduce_29,
  1, 54, :_reduce_30,
  1, 54, :_reduce_31,
  1, 54, :_reduce_32,
  1, 54, :_reduce_33,
  0, 51, :_reduce_none,
  1, 51, :_reduce_35,
  3, 51, :_reduce_36,
  0, 44, :_reduce_none,
  1, 44, :_reduce_38,
  3, 44, :_reduce_39,
  0, 47, :_reduce_none,
  1, 47, :_reduce_41,
  3, 47, :_reduce_42,
  1, 53, :_reduce_43,
  1, 53, :_reduce_none,
  1, 53, :_reduce_none,
  1, 55, :_reduce_none,
  1, 55, :_reduce_none,
  1, 41, :_reduce_48 ]

racc_reduce_n = 49

racc_shift_n = 79

racc_token_table = {
  false => 0,
  :error => 1,
  :kw_select => 2,
  :kw_from => 3,
  :kw_where => 4,
  :kw_null => 5,
  :kw_not => 6,
  :kw_insert => 7,
  :kw_into => 8,
  :kw_values => 9,
  :kw_create => 10,
  :kw_table => 11,
  :kw_constraint => 12,
  :kw_key => 13,
  :kw_primary => 14,
  :star => 15,
  :lparen => 16,
  :rparen => 17,
  :ws => 18,
  :op_or => 19,
  :op_and => 20,
  :op_lt => 21,
  :op_gt => 22,
  :op_gte => 23,
  :op_lte => 24,
  :identifier => 25,
  :op_equal => 26,
  :semicolon => 27,
  :comma => 28,
  :period => 29,
  :integer => 30,
  :string => 31 }

racc_nt_base = 32

racc_use_result_var = true

Racc_arg = [
  racc_action_table,
  racc_action_check,
  racc_action_default,
  racc_action_pointer,
  racc_goto_table,
  racc_goto_check,
  racc_goto_default,
  racc_goto_pointer,
  racc_nt_base,
  racc_reduce_table,
  racc_token_table,
  racc_shift_n,
  racc_reduce_n,
  racc_use_result_var ]

Racc_token_to_s_table = [
  "$end",
  "error",
  "kw_select",
  "kw_from",
  "kw_where",
  "kw_null",
  "kw_not",
  "kw_insert",
  "kw_into",
  "kw_values",
  "kw_create",
  "kw_table",
  "kw_constraint",
  "kw_key",
  "kw_primary",
  "star",
  "lparen",
  "rparen",
  "ws",
  "op_or",
  "op_and",
  "op_lt",
  "op_gt",
  "op_gte",
  "op_lte",
  "identifier",
  "op_equal",
  "semicolon",
  "comma",
  "period",
  "integer",
  "string",
  "$start",
  "statement",
  "query",
  "select_query",
  "create_table_query",
  "insert_into_query",
  "relation",
  "column_definitions",
  "column_definition",
  "symbol",
  "insert_columns",
  "insert_data",
  "symbol_collection",
  "values_collection",
  "values",
  "literal_collection",
  "select_stmt",
  "from_stmt",
  "where_stmt",
  "collection",
  "predicate",
  "atom",
  "binary_operator",
  "literal" ]

Racc_debug_parser = true

##### State transition tables end #####

# reduce 0 omitted

module_eval(<<'.,.,', 'parser.y', 35)
  def _reduce_1(val, _values, result)
     result = [val[0]]
    result
  end
.,.,

# reduce 2 omitted

# reduce 3 omitted

# reduce 4 omitted

module_eval(<<'.,.,', 'parser.y', 40)
  def _reduce_5(val, _values, result)
     result = [:create_table, val[2].merge(columns: val[4]) ]
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 42)
  def _reduce_6(val, _values, result)
     result = val
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 43)
  def _reduce_7(val, _values, result)
     result = val[0] << val[2]
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 44)
  def _reduce_8(val, _values, result)
     result = [val[0], val[1]]
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 45)
  def _reduce_9(val, _values, result)
     result = [:insert_into_query, val.values_at(2, 3, 4).reduce(&:merge)]
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 46)
  def _reduce_10(val, _values, result)
     {}
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 47)
  def _reduce_11(val, _values, result)
     result = { column_names: val[1] }
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 49)
  def _reduce_12(val, _values, result)
     result = Hash[val]
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 50)
  def _reduce_13(val, _values, result)
     result = { rows: val[1] }
    result
  end
.,.,

# reduce 14 omitted

module_eval(<<'.,.,', 'parser.y', 52)
  def _reduce_15(val, _values, result)
     result = val
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 53)
  def _reduce_16(val, _values, result)
     result = val[0] + [val[2]]
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 54)
  def _reduce_17(val, _values, result)
     result = val[1]
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 55)
  def _reduce_18(val, _values, result)
     result = [:select_query, [val[1], val[2], val[0]]]
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 56)
  def _reduce_19(val, _values, result)
     result = [:select, val[1]]
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 58)
  def _reduce_20(val, _values, result)
     result = [:from, val[1]]
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 60)
  def _reduce_21(val, _values, result)
     result = { schema_name: val[0], table_name: val[2] }
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 61)
  def _reduce_22(val, _values, result)
     result = { table_name: val[0].to_sym }
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 62)
  def _reduce_23(val, _values, result)
     result = [:where, val[1]]
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 64)
  def _reduce_24(val, _values, result)
     result = [val[1], [ val[0], val[2] ]]
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 65)
  def _reduce_25(val, _values, result)
     result = [val[1], [ val[0], val[2] ]]
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 66)
  def _reduce_26(val, _values, result)
     result = val[1]
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 68)
  def _reduce_27(val, _values, result)
     result = :'=='
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 69)
  def _reduce_28(val, _values, result)
     result = :or
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 70)
  def _reduce_29(val, _values, result)
     result = :and
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 71)
  def _reduce_30(val, _values, result)
     result = :<
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 72)
  def _reduce_31(val, _values, result)
     result = :<=
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 73)
  def _reduce_32(val, _values, result)
     result = :>
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 74)
  def _reduce_33(val, _values, result)
     result = :>=
    result
  end
.,.,

# reduce 34 omitted

module_eval(<<'.,.,', 'parser.y', 76)
  def _reduce_35(val, _values, result)
     result = val
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 77)
  def _reduce_36(val, _values, result)
     result = val[0] << val[2]
    result
  end
.,.,

# reduce 37 omitted

module_eval(<<'.,.,', 'parser.y', 79)
  def _reduce_38(val, _values, result)
     result = val
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 80)
  def _reduce_39(val, _values, result)
     result = val[0] << val[2]
    result
  end
.,.,

# reduce 40 omitted

module_eval(<<'.,.,', 'parser.y', 82)
  def _reduce_41(val, _values, result)
     result = val
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 83)
  def _reduce_42(val, _values, result)
     result = val[0] << val[2]
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 85)
  def _reduce_43(val, _values, result)
     result = val[0].to_sym
    result
  end
.,.,

# reduce 44 omitted

# reduce 45 omitted

# reduce 46 omitted

# reduce 47 omitted

module_eval(<<'.,.,', 'parser.y', 91)
  def _reduce_48(val, _values, result)
     result = val[0].downcase.to_sym
    result
  end
.,.,

def _reduce_none(val, _values, result)
  val[0]
end

  end   # class Parser
end   # module Rsql
