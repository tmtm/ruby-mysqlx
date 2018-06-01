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
    module Session
      ::Protobuf::Optionable.inject(self) { ::Google::Protobuf::FileOptions }

      ##
      # Message Classes
      #
      class AuthenticateStart < ::Protobuf::Message; end
      class AuthenticateContinue < ::Protobuf::Message; end
      class AuthenticateOk < ::Protobuf::Message; end
      class Reset < ::Protobuf::Message; end
      class Close < ::Protobuf::Message; end


      ##
      # File Options
      #
      set_option :java_package, "com.mysql.cj.x.protobuf"


      ##
      # Message Fields
      #
      class AuthenticateStart
        # Message Options
        set_option :".Mysqlx.Protobuf.client_message_id", ::Mysqlx::Protobuf::ClientMessages::Type::SESS_AUTHENTICATE_START

        required :string, :mech_name, 1
        optional :bytes, :auth_data, 2
        optional :bytes, :initial_response, 3
      end

      class AuthenticateContinue
        # Message Options
        set_option :".Mysqlx.Protobuf.client_message_id", ::Mysqlx::Protobuf::ClientMessages::Type::SESS_AUTHENTICATE_CONTINUE
        set_option :".Mysqlx.Protobuf.server_message_id", ::Mysqlx::Protobuf::ServerMessages::Type::SESS_AUTHENTICATE_CONTINUE

        required :bytes, :auth_data, 1
      end

      class AuthenticateOk
        # Message Options
        set_option :".Mysqlx.Protobuf.server_message_id", ::Mysqlx::Protobuf::ServerMessages::Type::SESS_AUTHENTICATE_OK

        optional :bytes, :auth_data, 1
      end

      class Reset
        # Message Options
        set_option :".Mysqlx.Protobuf.client_message_id", ::Mysqlx::Protobuf::ClientMessages::Type::SESS_RESET

      end

      class Close
        # Message Options
        set_option :".Mysqlx.Protobuf.client_message_id", ::Mysqlx::Protobuf::ClientMessages::Type::SESS_CLOSE

      end

    end

  end

end

