# encoding: utf-8

##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf'


##
# Imports
#
require 'google/protobuf/descriptor.pb'

module Mysqlx
  module Protobuf
    ::Protobuf::Optionable.inject(self) { ::Google::Protobuf::FileOptions }

    ##
    # Message Classes
    #
    class ClientMessages < ::Protobuf::Message
      class Type < ::Protobuf::Enum
        define :CON_CAPABILITIES_GET, 1
        define :CON_CAPABILITIES_SET, 2
        define :CON_CLOSE, 3
        define :SESS_AUTHENTICATE_START, 4
        define :SESS_AUTHENTICATE_CONTINUE, 5
        define :SESS_RESET, 6
        define :SESS_CLOSE, 7
        define :SQL_STMT_EXECUTE, 12
        define :CRUD_FIND, 17
        define :CRUD_INSERT, 18
        define :CRUD_UPDATE, 19
        define :CRUD_DELETE, 20
        define :EXPECT_OPEN, 24
        define :EXPECT_CLOSE, 25
        define :CRUD_CREATE_VIEW, 30
        define :CRUD_MODIFY_VIEW, 31
        define :CRUD_DROP_VIEW, 32
      end

    end

    class ServerMessages < ::Protobuf::Message
      class Type < ::Protobuf::Enum
        define :OK, 0
        define :ERROR, 1
        define :CONN_CAPABILITIES, 2
        define :SESS_AUTHENTICATE_CONTINUE, 3
        define :SESS_AUTHENTICATE_OK, 4
        define :NOTICE, 11
        define :RESULTSET_COLUMN_META_DATA, 12
        define :RESULTSET_ROW, 13
        define :RESULTSET_FETCH_DONE, 14
        define :RESULTSET_FETCH_SUSPENDED, 15
        define :RESULTSET_FETCH_DONE_MORE_RESULTSETS, 16
        define :SQL_STMT_EXECUTE_OK, 17
        define :RESULTSET_FETCH_DONE_MORE_OUT_PARAMS, 18
      end

    end

    class Ok < ::Protobuf::Message; end
    class Error < ::Protobuf::Message
      class Severity < ::Protobuf::Enum
        define :ERROR, 0
        define :FATAL, 1
      end

    end



    ##
    # File Options
    #
    set_option :java_package, "com.mysql.cj.x.protobuf"


    ##
    # Message Fields
    #
    class Ok
      # Message Options
      set_option :".Mysqlx.Protobuf.server_message_id", ::Mysqlx::Protobuf::ServerMessages::Type::OK

      optional :string, :msg, 1
    end

    class Error
      # Message Options
      set_option :".Mysqlx.Protobuf.server_message_id", ::Mysqlx::Protobuf::ServerMessages::Type::ERROR

      optional ::Mysqlx::Protobuf::Error::Severity, :severity, 1, :default => ::Mysqlx::Protobuf::Error::Severity::ERROR
      required :uint32, :code, 2
      required :string, :sql_state, 4
      required :string, :msg, 3
    end


    ##
    # Extended Message Fields
    #
    class ::Google::Protobuf::MessageOptions < ::Protobuf::Message
      optional ::Mysqlx::Protobuf::ClientMessages::Type, :".Mysqlx.Protobuf.client_message_id", 100001, :extension => true
      optional ::Mysqlx::Protobuf::ServerMessages::Type, :".Mysqlx.Protobuf.server_message_id", 100002, :extension => true
    end

  end

end

