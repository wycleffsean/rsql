require "test_helper"

module Rsql
  class QueryTest < Minitest::Test
    def setup
      @db = Database.new
      people = @db.create_table(table_name: :people)
      people.add_column :email, :string
      people.add_column :age, :integer, null: false
      people.insert age: 30, email: 'dude@example.com'
      people.insert age: 15, email: 'lildude@example.com'
      people.insert age: 10, email: 'lkjsdfkj@example.com'
      people.insert age: 50, email: 'mid@example.com'
      people.insert age: 80, email: 'old@example.com'
    end

    def test_simple_query
      res = Query.call @db, <<-SQL
        SELECT email FROM people WHERE age >= 30;
      SQL
      assert_equal 3, res.count
      assert_includes res, {email: "dude@example.com"}
      assert_includes res, {email: "mid@example.com"}
      assert_includes res, {email: "old@example.com"}
    end

    def test_query_with_fully_qualified_table
      res = Query.call @db, <<-SQL
        SELECT email FROM public.people WHERE age < 30;
      SQL
      assert_equal 2, res.count
      assert_includes res, { email: 'lildude@example.com' }
      assert_includes res, { email: 'lkjsdfkj@example.com' }
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
      assert_includes res, {email: "dude@example.com", age: 30}
      assert_includes res, {email: "mid@example.com", age: 50}
      assert_includes res, {email: "old@example.com", age: 80}
    end
  end
end
