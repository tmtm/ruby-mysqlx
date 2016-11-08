require "mysqlx/version"

module Mysqlx
  class Error < StandardError
    # @param error [Mysqlx::Protobuf::Error]
    def initialize(error)
      @code = error.code
      @sql_state = error.sql_state
      super(error.msg)
    end
  end

  class Field
    attr_accessor :type
    attr_accessor :name
    attr_accessor :original_name
    attr_accessor :table
    attr_accessor :original_table
    attr_accessor :schema
    attr_accessor :catalog
    attr_accessor :collation
    attr_accessor :fractional_digits
    attr_accessor :length
    attr_accessor :flags
    attr_accessor :content_type

    # @param meta [Mysqlx::Protobuf::Resultset::ColumnMetaData]
    def initialize(meta)
      self.type = meta.type.to_i
      self.name = meta.name
      self.original_name = meta.original_name
      self.table = meta.table
      self.original_table = meta.original_table
      self.schema = meta.schema
      self.catalog = meta.catalog
      self.collation = meta.collation
      self.fractional_digits = meta.fractional_digits
      self.length = meta.length
      self.flags = meta.flags
      self.content_type = meta.content_type
    end
  end

  class Result
    include Enumerable

    # @param fields [Array<Field>]
    # @param rows [Array<Array<Object>>]
    def initialize(fields, rows)
      @fields, @rows = fields, rows
    end

    def each(&block)
      @rows.each do |row|
        block.call row
      end
    end
  end
end
