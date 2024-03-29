# frozen_string_literal: true
# encoding: UTF-8
#--
# This file is automatically generated. Do not modify it.
# Generated by: oedipus_lex version 2.6.2.
# Source: lib/rsql/lexer.rex
#++


##
# The generated lexer Rsql::Lexer

class Rsql::Lexer
  require 'strscan'

  # :stopdoc:
  class LexerError < StandardError ; end
  class ScanError < LexerError ; end
  # :startdoc:

  ##
  # The file name / path

  attr_accessor :filename

  ##
  # The StringScanner for this lexer.

  attr_accessor :ss

  ##
  # The current lexical state.

  attr_accessor :state

  alias :match :ss

  ##
  # The match groups for the current scan.

  def matches
    m = (1..9).map { |i| ss[i] }
    m.pop until m[-1] or m.empty?
    m
  end

  ##
  # Yields on the current action.

  def action
    yield
  end

  ##
  # The current scanner class. Must be overridden in subclasses.

  def scanner_class
    StringScanner
  end unless instance_methods(false).map(&:to_s).include?("scanner_class")

  ##
  # Parse the given string.

  def parse str
    self.ss     = scanner_class.new str
    self.state  ||= nil

    do_parse
  end

  ##
  # Read in and parse the file at +path+.

  def parse_file path
    self.filename = path
    open path do |f|
      parse f.read
    end
  end

  ##
  # The current location in the parse.

  def location
    [
      (filename || "<input>"),
    ].compact.join(":")
  end

  ##
  # Lex the next token.

  def next_token

    token = nil

    until ss.eos? or token do
      token =
        case state
        when nil then
          case
          when text = ss.scan(/select/i) then
            action { [:kw_select, text] }
          when text = ss.scan(/from/i) then
            action { [:kw_from, text] }
          when text = ss.scan(/where/i) then
            action { [:kw_where, text] }
          when text = ss.scan(/null/i) then
            action { [:kw_null, text] }
          when text = ss.scan(/not/i) then
            action { [:kw_not, text] }
          when text = ss.scan(/limit/i) then
            action { [:kw_limit, text] }
          when text = ss.scan(/offset/i) then
            action { [:kw_offset, text] }
          when text = ss.scan(/insert/i) then
            action { [:kw_insert, text] }
          when text = ss.scan(/into/i) then
            action { [:kw_into, text] }
          when text = ss.scan(/values/i) then
            action { [:kw_values, text] }
          when text = ss.scan(/create\s/i) then
            action { [:kw_create, text] }
          when text = ss.scan(/table/i) then
            action { [:kw_table, text] }
          when text = ss.scan(/constraint/i) then
            action { [:kw_constraint, text] }
          when text = ss.scan(/key/i) then
            action { [:kw_key, text] }
          when text = ss.scan(/primary/i) then
            action { [:kw_primary, text] }
          when text = ss.scan(/\*/) then
            action { [:star, text] }
          when text = ss.scan(/\(/) then
            action { [:lparen, text] }
          when text = ss.scan(/\)/) then
            action { [:rparen, text] }
          when ss.skip(/\s+/) then
            # do nothing
          when text = ss.scan(/or\s/i) then
            action { [:op_or, text] }
          when text = ss.scan(/and\s/i) then
            action { [:op_and, text] }
          when text = ss.scan(/[a-zA-Z]\w*/) then
            action { [:identifier, text] }
          when text = ss.scan(/=/) then
            action { [:op_equal, text] }
          when text = ss.scan(/<=/) then
            action { [:op_lte, text] }
          when text = ss.scan(/>=/) then
            action { [:op_gte, text] }
          when text = ss.scan(/</) then
            action { [:op_lt, text] }
          when text = ss.scan(/>/) then
            action { [:op_gt, text] }
          when text = ss.scan(/;/) then
            action { [:semicolon, text] }
          when text = ss.scan(/,/) then
            action { [:comma, text] }
          when text = ss.scan(/\./) then
            action { [:period, text] }
          when text = ss.scan(/\d+/) then
            action { [:integer, text.to_i] }
          when ss.skip(/'/) then
            [:state, :QUOTE]
          when ss.skip(/--/) then
            [:state, :COMMENT]
          else
            text = ss.string[ss.pos .. -1]
            raise ScanError, "can not match (#{state.inspect}) at #{location}: '#{text}'"
          end
        when :QUOTE then
          case
          when ss.skip(/'/) then
            [:state, nil]
          when text = ss.scan(/[^']+/) then
            action { [:string, text] }
          else
            text = ss.string[ss.pos .. -1]
            raise ScanError, "can not match (#{state.inspect}) at #{location}: '#{text}'"
          end
        when :COMMENT then
          case
          when ss.skip(/\n/) then
            [:state, nil]
          when ss.skip(/./) then
            # do nothing
          else
            text = ss.string[ss.pos .. -1]
            raise ScanError, "can not match (#{state.inspect}) at #{location}: '#{text}'"
          end
        else
          raise ScanError, "undefined state at #{location}: '#{state}'"
        end # token = case state

      next unless token # allow functions to trigger redo w/ nil
    end # while

    raise LexerError, "bad lexical result at #{location}: #{token.inspect}" unless
      token.nil? || (Array === token && token.size >= 2)

    # auto-switch state
    self.state = token.last if token && token.first == :state

    token
  end # def next_token
end # class
