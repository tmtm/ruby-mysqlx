# encoding: utf-8

##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf'


##
# Imports
#
require_relative 'mysqlx.pb'

module Mysqlx
  module Protobuf
    module Resultset
      ::Protobuf::Optionable.inject(self) { ::Google::Protobuf::FileOptions }

      ##
      # Enum Classes
      #
      class ContentType_BYTES < ::Protobuf::Enum
        define :GEOMETRY, 1
        define :JSON, 2
        define :XML, 3
      end

      class ContentType_DATETIME < ::Protobuf::Enum
        define :DATE, 1
        define :DATETIME, 2
      end


      ##
      # Message Classes
      #
      class FetchDoneMoreOutParams < ::Protobuf::Message; end
      class FetchDoneMoreResultsets < ::Protobuf::Message; end
      class FetchDone < ::Protobuf::Message; end
      class ColumnMetaData < ::Protobuf::Message
        class FieldType < ::Protobuf::Enum
          define :SINT, 1
          define :UINT, 2
          define :DOUBLE, 5
          define :FLOAT, 6
          define :BYTES, 7
          define :TIME, 10
          define :DATETIME, 12
          define :SET, 15
          define :ENUM, 16
          define :BIT, 17
          define :DECIMAL, 18
        end

      end

      class Row < ::Protobuf::Message; end


      ##
      # File Options
      #
      set_option :java_package, "com.mysql.cj.x.protobuf"


      ##
      # Message Fields
      #
      class FetchDoneMoreOutParams
        # Message Options
        set_option :".Mysqlx.Protobuf.server_message_id", ::Mysqlx::Protobuf::ServerMessages::Type::RESULTSET_FETCH_DONE_MORE_OUT_PARAMS

      end

      class FetchDoneMoreResultsets
        # Message Options
        set_option :".Mysqlx.Protobuf.server_message_id", ::Mysqlx::Protobuf::ServerMessages::Type::RESULTSET_FETCH_DONE_MORE_RESULTSETS

      end

      class FetchDone
        # Message Options
        set_option :".Mysqlx.Protobuf.server_message_id", ::Mysqlx::Protobuf::ServerMessages::Type::RESULTSET_FETCH_DONE

      end

      class ColumnMetaData
        # Message Options
        set_option :".Mysqlx.Protobuf.server_message_id", ::Mysqlx::Protobuf::ServerMessages::Type::RESULTSET_COLUMN_META_DATA

        required ::Mysqlx::Protobuf::Resultset::ColumnMetaData::FieldType, :type, 1
        optional :bytes, :name, 2
        optional :bytes, :original_name, 3
        optional :bytes, :table, 4
        optional :bytes, :original_table, 5
        optional :bytes, :schema, 6
        optional :bytes, :catalog, 7
        optional :uint64, :collation, 8
        optional :uint32, :fractional_digits, 9
        optional :uint32, :length, 10
        optional :uint32, :flags, 11
        optional :uint32, :content_type, 12
      end

      class Row
        # Message Options
        set_option :".Mysqlx.Protobuf.server_message_id", ::Mysqlx::Protobuf::ServerMessages::Type::RESULTSET_ROW

        repeated :bytes, :field, 1
      end

    end

  end

end

