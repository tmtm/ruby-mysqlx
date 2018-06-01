# encoding: utf-8

##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf'


##
# Imports
#
require_relative 'mysqlx_datatypes.pb'
require_relative 'mysqlx.pb'

module Mysqlx
  module Protobuf
    module Connection
      ::Protobuf::Optionable.inject(self) { ::Google::Protobuf::FileOptions }

      ##
      # Message Classes
      #
      class Capability < ::Protobuf::Message; end
      class Capabilities < ::Protobuf::Message; end
      class CapabilitiesGet < ::Protobuf::Message; end
      class CapabilitiesSet < ::Protobuf::Message; end
      class Close < ::Protobuf::Message; end


      ##
      # File Options
      #
      set_option :java_package, "com.mysql.cj.x.protobuf"


      ##
      # Message Fields
      #
      class Capability
        required :string, :name, 1
        required ::Mysqlx::Protobuf::Datatypes::Any, :value, 2
      end

      class Capabilities
        # Message Options
        set_option :".Mysqlx.Protobuf.server_message_id", ::Mysqlx::Protobuf::ServerMessages::Type::CONN_CAPABILITIES

        repeated ::Mysqlx::Protobuf::Connection::Capability, :capabilities, 1
      end

      class CapabilitiesGet
        # Message Options
        set_option :".Mysqlx.Protobuf.client_message_id", ::Mysqlx::Protobuf::ClientMessages::Type::CON_CAPABILITIES_GET

      end

      class CapabilitiesSet
        # Message Options
        set_option :".Mysqlx.Protobuf.client_message_id", ::Mysqlx::Protobuf::ClientMessages::Type::CON_CAPABILITIES_SET

        required ::Mysqlx::Protobuf::Connection::Capabilities, :capabilities, 1
      end

      class Close
        # Message Options
        set_option :".Mysqlx.Protobuf.client_message_id", ::Mysqlx::Protobuf::ClientMessages::Type::CON_CLOSE

      end

    end

  end

end

