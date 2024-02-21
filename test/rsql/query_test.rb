require 'test_helper'

module Rsql
  class QueryTest < Minitest::Test
    def setup
      @db = Database.new
      setup_people
      setup_orders
    end

    def setup_people
      people = @db.create_table(table_name: :people)
      people.add_column :email, :string
      people.add_column :age, :integer, null: false
      people.insert age: 30, email: 'dude@example.com'
      people.insert age: 15, email: 'lildude@example.com'
      people.insert age: 10, email: 'lkjsdfkj@example.com'
      people.insert age: 50, email: 'mid@example.com'
      people.insert age: 80, email: 'old@example.com'
    end

    def setup_orders
      orders = @db.create_table(table_name: :orders)
      orders.add_column :id, :integer, null: false
      orders.insert id: 30
      orders.insert id: 15
      orders.insert id: 10
      orders.insert id: 50
      orders.insert id: 80
    end

    def test_trivial_query
      Query.call @db, 'SELECT * FROM people;'
    end

    def test_simple_query
      res = Query.call @db, <<-SQL
        SELECT email FROM people WHERE age >= 30;
      SQL
      assert_equal 3, res.count
      assert_includes res, { email: 'dude@example.com' }
      assert_includes res, { email: 'mid@example.com' }
      assert_includes res, { email: 'old@example.com' }
    end

    # TODO: this should really be a parser/lexer test
    def test_simple_query_from_table_with_keyword_conflict
      # orders accidentally parses as "or" keyword
      res = Query.call @db, <<-SQL
        SELECT email FROM orders;
      SQL
      assert_equal 5, res.count
    end

    def test_query_with_fully_qualified_table
      res = Query.call @db, <<-SQL
        SELECT email FROM public.people WHERE age < 30;
      SQL
      assert_equal 2, res.count
      assert_includes res, { email: 'lildude@example.com' }
      assert_includes res, { email: 'lkjsdfkj@example.com' }
    end

    def test_query_with_limit
      res = Query.call @db, <<-SQL
        SELECT email FROM public.people WHERE age < 30 LIMIT 1;
      SQL
      assert_equal 1, res.count
      assert_includes res, { email: 'lildude@example.com' }
    end

    def test_query_with_offset
      res = Query.call @db, <<-SQL
        SELECT email FROM public.people WHERE age < 30 OFFSET 1;
      SQL
      assert_equal 1, res.count
      assert_includes res, { email: 'lkjsdfkj@example.com' }
    end

    def test_query_with_limit_and_offset
      res = Query.call @db, <<-SQL
        SELECT email FROM public.people WHERE age > 10 LIMIT 2 OFFSET 2;
      SQL
      assert_equal 2, res.count
      assert_includes res, { email: 'mid@example.com' }
      assert_includes res, { email: 'old@example.com' }
    end

    def test_create_query
      db = Database.new
      res = Query.call db, <<-SQL
      CREATE TABLE people (
        email TEXT,
        age INT
      );
      SQL
      assert_kind_of Column::String, db.schemas[:public][:people].columns[:email]
      assert_kind_of Column::Integer, db.schemas[:public][:people].columns[:age]
    end

    def test_insert_into
      count = @db.schemas[:public][:people].count
      res = Query.call @db, <<-SQL
        INSERT INTO people(age, email) VALUES (12, 'abc@example.com'), (10, 'foo@place.com');
      SQL
      assert_equal count + 2, @db.schemas[:public][:people].count
    end

    def test_insert_into_with_select_star
      count = @db.schemas[:public][:people].count
      res = Query.call @db, <<-SQL
        INSERT INTO people(age, email)
        SELECT age, email FROM people WHERE age >= 30;
      SQL
      assert_equal 3, res.count
      assert_includes res, { email: 'dude@example.com', age: 30 }
      assert_includes res, { email: 'mid@example.com', age: 50 }
      assert_includes res, { email: 'old@example.com', age: 80 }
    end
  end
end
