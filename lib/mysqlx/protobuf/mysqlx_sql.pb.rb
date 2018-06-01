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
    module Sql
      ::Protobuf::Optionable.inject(self) { ::Google::Protobuf::FileOptions }

      ##
      # Message Classes
      #
      class StmtExecute < ::Protobuf::Message; end
      class StmtExecuteOk < ::Protobuf::Message; end


      ##
      # File Options
      #
      set_option :java_package, "com.mysql.cj.x.protobuf"


      ##
      # Message Fields
      #
      class StmtExecute
        # Message Options
        set_option :".Mysqlx.Protobuf.client_message_id", ::Mysqlx::Protobuf::ClientMessages::Type::SQL_STMT_EXECUTE

        optional :string, :namespace, 3, :default => "sql"
        required :bytes, :stmt, 1
        repeated ::Mysqlx::Protobuf::Datatypes::Any, :args, 2
        optional :bool, :compact_metadata, 4, :default => false
      end

      class StmtExecuteOk
        # Message Options
        set_option :".Mysqlx.Protobuf.server_message_id", ::Mysqlx::Protobuf::ServerMessages::Type::SQL_STMT_EXECUTE_OK

      end

    end

  end

end

