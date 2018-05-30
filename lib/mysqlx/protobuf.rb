Dir.glob('protobuf/mysqlx*.pb.rb', base: __dir__) do |pb|
  require_relative pb
end

module Mysqlx
  module Protobuf
    module Datatypes
      # @param obj [Object]
      # @return [Protobuf::Datatypes::Scalar]
      def self.Scalar(obj)
        case obj
        when Integer
          if obj < 0
            type = Protobuf::Datatypes::Scalar::Type::V_SINT
            Protobuf::Datatypes::Scalar.new(type: type, v_signed_int: obj)
          else
            type = Protobuf::Datatypes::Scalar::Type::V_UINT
            Protobuf::Datatypes::Scalar.new(type: type, v_unsigned_int: obj)
          end
        when Float
          type = Protobuf::Datatypes::Scalar::Type::V_DOUBLE
          Protobuf::Datatypes::Scalar.new(type: type, v_double: obj)
        when String
          type = Protobuf::Datatypes::Scalar::Type::V_STRING
          str = Protobuf::Datatypes::Scalar::String.new(value: obj)
          Protobuf::Datatypes::Scalar.new(type: type, v_string: str)
        when true, false
          type = Protobuf::Datatypes::Scalar::Type::V_BOOL
          Protobuf::Datatypes::Scalar.new(type: type, v_bool: obj)
        when nil
          type = Protobuf::Datatypes::Scalar::Type::V_NULL
          Protobuf::Datatypes::Scalar.new(type: type)
        else
          raise "unsupported type: #{obj.inspect}"
        end
      end

      # @param obj [Object]
      # @return [Protobuf::Datatypes::Any]
      def self.Any(obj)
        any = Protobuf::Datatypes::Any.new
        case obj
        when ::Array
          any.type = Protobuf::Datatypes::Any::Type::ARRAY
          any.array = Protobuf::Datatypes::Array.new
          obj.each do |o|
            any.array.value.push Any(o)
          end
        when ::Hash
          any.type = Protobuf::Datatypes::Any::Type::OBJECT
          fld = obj.map do |key, value|
            Protobuf::Datatypes::Object::ObjectField.new(key: key.to_s, value: Any(value))
          end
          any.obj = Protobuf::Datatypes::Object.new(fld: fld)
        else
          any.type = Protobuf::Datatypes::Any::Type::SCALAR
          any.scalar = Scalar(obj)
        end
        any
      end

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
          "#<Scalar::#{type}:#{to_object.inspect}>"
        end
      end

      class Array
        def to_object
          value.map(&:to_object)
        end

        def inspect
          "#<Array:#{to_object.inspect}>"
        end
      end

      class Object
        def to_object
          fld.map{|f| [f.key, f.value]}.to_h
        end

        def inspect
          "#<Object:#{to_object.inspect}>"
        end
      end

      class Any
        def to_object
          case type
          when Type::SCALAR
            scalar.to_object
          when Type::OBJECT
            obj.to_object
          when Type::ARRAY
            array.to_object
          end
        end

        def inspect
          "#<Any::#{type}:#{to_object.inspect}>"
        end
      end
    end
  end
end
