module Mysqlx
  class Table
    attr_reader :schema
    attr_reader :name

    def initialize(schema, name)
      @schema = schema
      @name = name
      res = schema.session.proto.sql_execute('list_objects', {'pattern'=>name, 'schema'=>schema.name}, namespace: 'mysqlx')
    end

    alias get_schema schema

    alias get_name name

    def count
    end

    def select
    end

    def insert(*fields)
      InsertStatement.new(self, *fields)
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
      "#<#{self.class}:#{name}>"
    end
  end

  class InsertStatement
    attr_reader :table
    attr_reader :fields

    def initialize(table, *fields)
      @table = table
      @fields = fields
      @records = []
    end

    def values(*values)
      @records.push values
      self
    end

    def execute
      i = Protobuf::Crud::Insert.new
      i.collection = Protobuf::Crud::Collection.new(name: @table.name, schema: @table.schema.name)
      i.data_model = Protobuf::Crud::DataModel::TABLE
      i.projection = @fields.map{|name| Protobuf::Crud::Column.new(name: name) }
      i.row = @records.map do |values|
        fields = values.map do |value|
          Protobuf::Expr::Expr.new(type: Protobuf::Expr::Expr::Type::LITERAL, literal: Protobuf::Datatypes::Scalar(value))
        end
        Protobuf::Crud::Insert::TypedRow.new(field: fields)
      end
      proto = table.schema.session.proto
      proto.send(i)
      Result.new(proto)
    end

    def inspect
      "#<#{self.class}:#{@fields.inspect}:#{@records.size} records>"
    end
  end
end
