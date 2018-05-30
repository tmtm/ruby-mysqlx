module Mysqlx
  class Session
    attr_reader :proto

    # @param uri [String] mysqlx://user:passwd@hostname:port
    # @param user [String]
    # @param password [String]
    # @param host [String]
    # @param port [String, Integer]
    def initialize(uri=nil, user: nil, password: nil, host: nil, port: nil)
      if uri
        u = URI.parse(uri)
        host ||= u.host
        port ||= u.port
        user ||= u.user
        password ||= u.password
      end
      socket = TCPSocket.new(host, port)
      @proto = Mysqlx::Protocol.new(socket)
      @proto.authenticate(user, password)
      @name = "#{user}@#{host}:#{port}"
    end

    def close
    end

    def get_default_schema
    end

    alias default_schema get_default_schema

    def get_schema(name)
      Schema.new(self, name)
    end

    alias schema get_schema

    def get_schemas
      @proto.sql_execute("show databases").map{|rec| Schema.new(self, rec.first) }
    end

    alias schemas get_schemas

    def create_schema(name)
    end

    def drop_schema(name)
    end

    def set_current_schema(name)
    end

    def sql(statement)
    end

    def start_transaction
    end

    def commit
    end

    def rollback
    end

    def set_savepoint(name=nil)
    end

    def release_savepoint(name)
    end

    def rollback_to(name)
    end

    def inspect
      "#<#{self.class}:#{@name}>"
    end
  end
end

