# encoding: utf-8

##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf'


##
# Imports
#
require_relative 'mysqlx.pb'
require_relative 'mysqlx_datatypes.pb'

module Mysqlx
  module Protobuf
    module Notice
      ::Protobuf::Optionable.inject(self) { ::Google::Protobuf::FileOptions }

      ##
      # Message Classes
      #
      class Frame < ::Protobuf::Message
        class Scope < ::Protobuf::Enum
          define :GLOBAL, 1
          define :LOCAL, 2
        end

        class Type < ::Protobuf::Enum
          define :WARNING, 1
          define :SESSION_VARIABLE_CHANGED, 2
          define :SESSION_STATE_CHANGED, 3
        end

      end

      class Warning < ::Protobuf::Message
        class Level < ::Protobuf::Enum
          define :NOTE, 1
          define :WARNING, 2
          define :ERROR, 3
        end

      end

      class SessionVariableChanged < ::Protobuf::Message; end
      class SessionStateChanged < ::Protobuf::Message
        class Parameter < ::Protobuf::Enum
          define :CURRENT_SCHEMA, 1
          define :ACCOUNT_EXPIRED, 2
          define :GENERATED_INSERT_ID, 3
          define :ROWS_AFFECTED, 4
          define :ROWS_FOUND, 5
          define :ROWS_MATCHED, 6
          define :TRX_COMMITTED, 7
          define :TRX_ROLLEDBACK, 9
          define :PRODUCED_MESSAGE, 10
          define :CLIENT_ID_ASSIGNED, 11
          define :GENERATED_DOCUMENT_IDS, 12
        end

      end



      ##
      # File Options
      #
      set_option :java_package, "com.mysql.cj.x.protobuf"


      ##
      # Message Fields
      #
      class Frame
        # Message Options
        set_option :".Mysqlx.Protobuf.server_message_id", ::Mysqlx::Protobuf::ServerMessages::Type::NOTICE

        required :uint32, :type, 1
        optional ::Mysqlx::Protobuf::Notice::Frame::Scope, :scope, 2, :default => ::Mysqlx::Protobuf::Notice::Frame::Scope::GLOBAL
        optional :bytes, :payload, 3
      end

      class Warning
        optional ::Mysqlx::Protobuf::Notice::Warning::Level, :level, 1, :default => ::Mysqlx::Protobuf::Notice::Warning::Level::WARNING
        required :uint32, :code, 2
        required :string, :msg, 3
      end

      class SessionVariableChanged
        required :string, :param, 1
        optional ::Mysqlx::Protobuf::Datatypes::Scalar, :value, 2
      end

      class SessionStateChanged
        required ::Mysqlx::Protobuf::Notice::SessionStateChanged::Parameter, :param, 1
        repeated ::Mysqlx::Protobuf::Datatypes::Scalar, :value, 2
      end

    end

  end

end

