module Mysqlx
  class Table
    attr_reader :name

    def initialize(schema, name)
      @name = name
      res = schema.session.proto.sql_execute('list_objects', {'pattern'=>name, 'schema'=>schema.name}, namespace: 'mysqlx')
    end

    def get_schema
    end

    alias schema get_schema

    alias get_name name

    def count
    end

    def select
    end

    def insert
    end

    def update
    end

    def delete
    end

    def drop_index
    end

    def get_indexes
    end

    def inspect
      "#<Mysqlx::Table:#{name}>"
    end
  end
end
