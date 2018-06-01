# encoding: utf-8

##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf'

module Mysqlx
  module Protobuf
    module Datatypes
      ::Protobuf::Optionable.inject(self) { ::Google::Protobuf::FileOptions }

      ##
      # Message Classes
      #
      class Scalar < ::Protobuf::Message
        class Type < ::Protobuf::Enum
          define :V_SINT, 1
          define :V_UINT, 2
          define :V_NULL, 3
          define :V_OCTETS, 4
          define :V_DOUBLE, 5
          define :V_FLOAT, 6
          define :V_BOOL, 7
          define :V_STRING, 8
        end

        class String < ::Protobuf::Message; end
        class Octets < ::Protobuf::Message; end

      end

      class Object < ::Protobuf::Message
        class ObjectField < ::Protobuf::Message; end

      end

      class Array < ::Protobuf::Message; end
      class Any < ::Protobuf::Message
        class Type < ::Protobuf::Enum
          define :SCALAR, 1
          define :OBJECT, 2
          define :ARRAY, 3
        end

      end



      ##
      # File Options
      #
      set_option :java_package, "com.mysql.cj.x.protobuf"


      ##
      # Message Fields
      #
      class Scalar
        class String
          required :bytes, :value, 1
          optional :uint64, :collation, 2
        end

        class Octets
          required :bytes, :value, 1
          optional :uint32, :content_type, 2
        end

        required ::Mysqlx::Protobuf::Datatypes::Scalar::Type, :type, 1
        optional :sint64, :v_signed_int, 2
        optional :uint64, :v_unsigned_int, 3
        optional ::Mysqlx::Protobuf::Datatypes::Scalar::Octets, :v_octets, 5
        optional :double, :v_double, 6
        optional :float, :v_float, 7
        optional :bool, :v_bool, 8
        optional ::Mysqlx::Protobuf::Datatypes::Scalar::String, :v_string, 9
      end

      class Object
        class ObjectField
          required :string, :key, 1
          required ::Mysqlx::Protobuf::Datatypes::Any, :value, 2
        end

        repeated ::Mysqlx::Protobuf::Datatypes::Object::ObjectField, :fld, 1
      end

      class Array
        repeated ::Mysqlx::Protobuf::Datatypes::Any, :value, 1
      end

      class Any
        required ::Mysqlx::Protobuf::Datatypes::Any::Type, :type, 1
        optional ::Mysqlx::Protobuf::Datatypes::Scalar, :scalar, 2
        optional ::Mysqlx::Protobuf::Datatypes::Object, :obj, 3
        optional ::Mysqlx::Protobuf::Datatypes::Array, :array, 4
      end

    end

  end

end

