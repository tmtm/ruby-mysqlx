module Mysqlx
  class Schema
    attr_reader :session
    attr_reader :name

    def initialize(session, name)
      @session = session
      @name = name
    end

    alias get_name name

    alias get_session session

    def get_collections(name)
      Collection.new(self, name)
    end

    alias collections get_collections

    def get_table(name)
      Table.new(self, name)
    end

    alias table get_table

    def get_collection_as_table(name)
    end

    alias collection_as_table get_collection_as_table

    def create_collection(name)
    end

    def get_collection_names
    end

    alias collection_names get_collection_names

    def get_table_names
    end

    alias table_names get_table_names

    def get_view_names
    end

    alias view_names get_view_names

    def get_collections
    end

    alias collections get_collections

    def get_tables
      @session.proto.sql_execute('list_objects', {'schema'=>@name}, namespace: 'mysqlx')
    end

    alias tables get_tables

    def get_views
    end

    alias views get_views

    def inspect
      "#<Mysqlx::Schema:#{@name}>"
    end
  end
end
