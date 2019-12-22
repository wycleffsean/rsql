module Rsql

  class Query
    def self.call(query_str)
      p = Parser.new
      ast = p.parse(query_str)
      new(*ast[1]).call
    end

    def initialize(*args)
      p args
      @args = args
    end

    def call
      @args.reduce do |acc, (name, args)|
        send(name, *args)
      end
    end

    private

    def select(*columns)
      @table.select(*columns)
    end

    def from(relation)
      @table = Table.new
      @table.add_column :email, :string
      @table.add_column :age, :integer, null: false
      @table.insert age: 30, email: 'dude@example.com'
      @table.insert age: 15, email: 'lildude@example.com'
      @table.insert age: 10, email: 'lkjsdfkj@example.com'
      @table.insert age: 50, email: 'mid@example.com'
      @table.insert age: 80, email: 'old@example.com'
      @table
    end

    def where(*predicates)
      @table.reduce
    end
  end
end
