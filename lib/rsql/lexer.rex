class Rsql::Lexer
rules
  /select/i       { [:kw_select, text] }
  /from/i         { [:kw_from, text] }
  /where/i        { [:kw_where, text] }
  /null/i         { [:kw_null, text] }
  /not/i          { [:kw_not, text] }
  /insert/i       { [:kw_insert, text] }
  /into/i         { [:kw_into, text] }
  /values/i       { [:kw_values, text] }
  /create/i       { [:kw_create, text] }
  /table/i        { [:kw_table, text] }
  /constraint/i   { [:kw_constraint, text] }
  /key/i          { [:kw_key, text] }
  /primary/i      { [:kw_primary, text] }
  /\*/            { [:star, text] }
  /\(/            { [:lparen, text] }
  /\)/            { [:rparen, text] }
  /\s+/           { [:ws, text] }
  /[a-zA-Z]\w+/   { [:identifier, text] }
  /=/             { [:op_equal, text] }
  /;/             { [:colon, text] }
  /,/             { [:comma, text] }
  /\d+/           { [:integer, text.to_i] }
  /'/		  :QUOTE
  :QUOTE /'/      nil
  :QUOTE /[^']+/  { [:string, text] }
end
