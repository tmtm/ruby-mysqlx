# encoding: utf-8

##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf'


##
# Imports
#
require_relative 'mysqlx_datatypes.pb'

module Mysqlx
  module Protobuf
    module Expr
      ::Protobuf::Optionable.inject(self) { ::Google::Protobuf::FileOptions }

      ##
      # Message Classes
      #
      class Expr < ::Protobuf::Message
        class Type < ::Protobuf::Enum
          define :IDENT, 1
          define :LITERAL, 2
          define :VARIABLE, 3
          define :FUNC_CALL, 4
          define :OPERATOR, 5
          define :PLACEHOLDER, 6
          define :OBJECT, 7
          define :ARRAY, 8
        end

      end

      class Identifier < ::Protobuf::Message; end
      class DocumentPathItem < ::Protobuf::Message
        class Type < ::Protobuf::Enum
          define :MEMBER, 1
          define :MEMBER_ASTERISK, 2
          define :ARRAY_INDEX, 3
          define :ARRAY_INDEX_ASTERISK, 4
          define :DOUBLE_ASTERISK, 5
        end

      end

      class ColumnIdentifier < ::Protobuf::Message; end
      class FunctionCall < ::Protobuf::Message; end
      class Operator < ::Protobuf::Message; end
      class Object < ::Protobuf::Message
        class ObjectField < ::Protobuf::Message; end

      end

      class Array < ::Protobuf::Message; end


      ##
      # File Options
      #
      set_option :java_package, "com.mysql.cj.x.protobuf"


      ##
      # Message Fields
      #
      class Expr
        required ::Mysqlx::Protobuf::Expr::Expr::Type, :type, 1
        optional ::Mysqlx::Protobuf::Expr::ColumnIdentifier, :identifier, 2
        optional :string, :variable, 3
        optional ::Mysqlx::Protobuf::Datatypes::Scalar, :literal, 4
        optional ::Mysqlx::Protobuf::Expr::FunctionCall, :function_call, 5
        optional ::Mysqlx::Protobuf::Expr::Operator, :operator, 6
        optional :uint32, :position, 7
        optional ::Mysqlx::Protobuf::Expr::Object, :object, 8
        optional ::Mysqlx::Protobuf::Expr::Array, :array, 9
      end

      class Identifier
        required :string, :name, 1
        optional :string, :schema_name, 2
      end

      class DocumentPathItem
        required ::Mysqlx::Protobuf::Expr::DocumentPathItem::Type, :type, 1
        optional :string, :value, 2
        optional :uint32, :index, 3
      end

      class ColumnIdentifier
        repeated ::Mysqlx::Protobuf::Expr::DocumentPathItem, :document_path, 1
        optional :string, :name, 2
        optional :string, :table_name, 3
        optional :string, :schema_name, 4
      end

      class FunctionCall
        required ::Mysqlx::Protobuf::Expr::Identifier, :name, 1
        repeated ::Mysqlx::Protobuf::Expr::Expr, :param, 2
      end

      class Operator
        required :string, :name, 1
        repeated ::Mysqlx::Protobuf::Expr::Expr, :param, 2
      end

      class Object
        class ObjectField
          required :string, :key, 1
          required ::Mysqlx::Protobuf::Expr::Expr, :value, 2
        end

        repeated ::Mysqlx::Protobuf::Expr::Object::ObjectField, :fld, 1
      end

      class Array
        repeated ::Mysqlx::Protobuf::Expr::Expr, :value, 1
      end

    end

  end

end

