require_relative 'protobuf/mysqlx.pb'

module Mysqlx
  module Protobuf
    module Datatypes
      class Scalar
        def to_object
          case type
          when Type::V_SINT
            v_signed_int
          when Type::V_UINT
            v_unsigned_int
          when Type::V_NULL
            nil
          when Type::V_OCTETS
            raise 'not implemented'
          when Type::V_DOUBLE
            v_double
          when Type::V_FLOAT
            v_float
          when Type::V_BOOL
            v_bool
          when Type::V_STRING
            v_string.value
          else
            raise "unknown type: #{type.inspect}"
          end
        end

        def inspect
          to_object.inspect
        end
      end

      class Array
        def to_object
          value.map(&:to_object)
        end

        def inspect
          to_object.inspect
        end
      end

      class Any
        def to_object
          case type
          when Type::SCALAR
            scalar.to_object
          when Type::OBJECT
            raise 'not implemented'
          when Type::ARRAY
            array.to_object
          end
        end

        def inspect
          to_object.inspect
        end
      end
    end
  end
end
