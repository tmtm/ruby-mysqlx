require 'openssl'

module Mysqlx
  class Session
    attr_reader :proto

    # @param uri [String] mysqlx://user:passwd@hostname:port
    # @param user [String]
    # @param password [String]
    # @param host [String]
    # @param port [String, Integer]
    # @param ssl [TrueClass|Hash] SSL/TLS options you use. :protocol and the writable accessors of OpenSSL::SSL::SSLContext is available.
    def initialize(uri=nil, user: nil, password: nil, host: nil, port: nil, ssl: true)
      if uri
        u = URI.parse(uri)
        host ||= u.host
        port ||= u.port
        user ||= u.user
        password ||= u.password
      end
      socket = create_socket(host, port, ssl)
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

    def create_socket(host, port, ssl)
      raw_socket = TCPSocket.new(host, port)
      return raw_socket unless ssl

      ssl_context = create_ssl_context(ssl)
      OpenSSL::SSL::SSLSocket.new(raw_socket, ssl_context)
    end

    DEFAULT_SSL_VERSION = :TLSv1_2

    def create_ssl_context(ssl)
      if ssl.respond_to?(:[])
        options = ssl.dup
        protocol = options.delete(:protocol)
      else
        no_options = true
      end
      protocol ||= DEFAULT_SSL_VERSION
      context = OpenSSL::SSL::SSLContext.new(protocol)

      return context if no_options

      options.each do |key, value|
        begin
          context.send(:"#{key}=", value)
        rescue NoMethodError
          raise ArgumentError, "Unsupported ssl option #{key}. See https://docs.ruby-lang.org/ja/#{RUBY_VERSION.split('.').take(2).join('.')}.0/class/OpenSSL=3a=3aSSL=3a=3aSSLContext.html"
        end
      end

      context
    end
  end
end

