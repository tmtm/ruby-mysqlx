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
    module Expect
      ::Protobuf::Optionable.inject(self) { ::Google::Protobuf::FileOptions }

      ##
      # Message Classes
      #
      class Open < ::Protobuf::Message
        class CtxOperation < ::Protobuf::Enum
          define :EXPECT_CTX_COPY_PREV, 0
          define :EXPECT_CTX_EMPTY, 1
        end

        class Condition < ::Protobuf::Message
          class Key < ::Protobuf::Enum
            define :EXPECT_NO_ERROR, 1
            define :EXPECT_FIELD_EXIST, 2
            define :EXPECT_DOCID_GENERATED, 3
          end

          class ConditionOperation < ::Protobuf::Enum
            define :EXPECT_OP_SET, 0
            define :EXPECT_OP_UNSET, 1
          end

        end


      end

      class Close < ::Protobuf::Message; end


      ##
      # File Options
      #
      set_option :java_package, "com.mysql.cj.x.protobuf"


      ##
      # Message Fields
      #
      class Open
        class Condition
          required :uint32, :condition_key, 1
          optional :bytes, :condition_value, 2
          optional ::Mysqlx::Protobuf::Expect::Open::Condition::ConditionOperation, :op, 3, :default => ::Mysqlx::Protobuf::Expect::Open::Condition::ConditionOperation::EXPECT_OP_SET
        end

        # Message Options
        set_option :".Mysqlx.Protobuf.client_message_id", ::Mysqlx::Protobuf::ClientMessages::Type::EXPECT_OPEN

        optional ::Mysqlx::Protobuf::Expect::Open::CtxOperation, :op, 1, :default => ::Mysqlx::Protobuf::Expect::Open::CtxOperation::EXPECT_CTX_COPY_PREV
        repeated ::Mysqlx::Protobuf::Expect::Open::Condition, :cond, 2
      end

      class Close
        # Message Options
        set_option :".Mysqlx.Protobuf.client_message_id", ::Mysqlx::Protobuf::ClientMessages::Type::EXPECT_CLOSE

      end

    end

  end

end

