module Mysqlx
  class Collection
    def initialize(schema, name)
    end

    def get_schema
    end

    alias schema get_schema

    def get_name
    end

    alias name get_name

    def count
    end

    def find(condition=nil)
    end

    def add(data)
      data = [data] if data.is_a? Hash
      data.each do |d|
        d
      end
    end

    def modify
    end

    def remove(condition)
    end

    def create_index
    end

    def drop_index
    end

    def get_indexes
    end

    def new_doc
    end
  end
end
