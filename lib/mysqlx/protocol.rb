require 'bigdecimal'
require 'digest'
require_relative 'protobuf'

module Mysqlx
  class Protocol

    # Client Message => type
    ClientMessage = {
      Protobuf::Connection::CapabilitiesGet => Protobuf::ClientMessages::Type::CON_CAPABILITIES_GET.to_i,
      Protobuf::Connection::CapabilitiesSet => Protobuf::ClientMessages::Type::CON_CAPABILITIES_SET.to_i,
      Protobuf::Connection::Close => Protobuf::ClientMessages::Type::CON_CLOSE.to_i,
      Protobuf::Session::AuthenticateStart => Protobuf::ClientMessages::Type::SESS_AUTHENTICATE_START.to_i,
      Protobuf::Session::AuthenticateContinue => Protobuf::ClientMessages::Type::SESS_AUTHENTICATE_CONTINUE.to_i,
      Protobuf::Session::Reset => Protobuf::ClientMessages::Type::SESS_RESET.to_i,
      Protobuf::Session::Close => Protobuf::ClientMessages::Type::SESS_CLOSE.to_i,
      Protobuf::Sql::StmtExecute => Protobuf::ClientMessages::Type::SQL_STMT_EXECUTE.to_i,
      Protobuf::Crud::Find => Protobuf::ClientMessages::Type::CRUD_FIND.to_i,
      Protobuf::Crud::Insert => Protobuf::ClientMessages::Type::CRUD_INSERT.to_i,
      Protobuf::Crud::Update => Protobuf::ClientMessages::Type::CRUD_UPDATE.to_i,
      Protobuf::Crud::Delete => Protobuf::ClientMessages::Type::CRUD_DELETE.to_i,
      Protobuf::Expect::Open => Protobuf::ClientMessages::Type::EXPECT_OPEN.to_i,
      Protobuf::Expect::Close => Protobuf::ClientMessages::Type::EXPECT_CLOSE.to_i,
    }

    # type => Server Message
    ServerMessage = {
      Protobuf::ServerMessages::Type::OK.to_i => Protobuf::Ok,
      Protobuf::ServerMessages::Type::ERROR.to_i => Protobuf::Error,
      Protobuf::ServerMessages::Type::CONN_CAPABILITIES.to_i => Protobuf::Connection::Capabilities,
      Protobuf::ServerMessages::Type::SESS_AUTHENTICATE_CONTINUE.to_i => Protobuf::Session::AuthenticateContinue,
      Protobuf::ServerMessages::Type::SESS_AUTHENTICATE_OK.to_i => Protobuf::Session::AuthenticateOk,
      Protobuf::ServerMessages::Type::NOTICE.to_i => Protobuf::Notice::Frame,
      Protobuf::ServerMessages::Type::RESULTSET_COLUMN_META_DATA.to_i => Protobuf::Resultset::ColumnMetaData,
      Protobuf::ServerMessages::Type::RESULTSET_ROW.to_i => Protobuf::Resultset::Row,
      Protobuf::ServerMessages::Type::RESULTSET_FETCH_DONE.to_i => Protobuf::Resultset::FetchDone,
      Protobuf::ServerMessages::Type::RESULTSET_FETCH_DONE_MORE_RESULTSETS.to_i => Protobuf::Resultset::FetchDoneMoreResultsets,
      Protobuf::ServerMessages::Type::SQL_STMT_EXECUTE_OK.to_i => Protobuf::Sql::StmtExecuteOk,
      Protobuf::ServerMessages::Type::RESULTSET_FETCH_DONE_MORE_OUT_PARAMS.to_i => Protobuf::Resultset::FetchDoneMoreOutParams,
    }

    # @param sock [Socket]
    def initialize(sock)
      @sock = sock
    end

    # @param type [Integer]
    # @param protobuf [::Protobuf::Message]
    def send(protobuf)
      type = ClientMessage[protobuf.class]
      data = protobuf.encode
      @sock.write([data.size+1, type].pack('VC'))
      @sock.write(data)
    end

    # @return [::Protobuf::Message]
    # @raise [Mysqlx::Error] Mysqlx::Protobuf::Error is receieved
    # @raise [EOFError] connection is closed unexpectedly
    def recv
      head = @sock.read(5)
      raise EOFError unless head && head.length == 5
      size, type = head.unpack('VC')
      data = @sock.read(size-1)
      raise EOFError unless data && data.length == size-1
      resp = ServerMessage[type].decode(data)
      raise Mysqlx::Error.new(resp) if resp.is_a? Mysqlx::Protobuf::Error
      resp
    end

    # @param user [String]
    # @param password [String]
    # @param database [String]
    def authenticate(user, password, database=nil)
      AuthSha256Memory.new(self).authenticate(user, password, database)
    end

    # @param sql [String]
    # @param args [Array<Object>]
    # @return [Mysqlx::Result]
    def sql_execute(sql, *args, namespace: 'sql')
      send(Protobuf::Sql::StmtExecute.new(stmt: sql, args: args.map{|a| Protobuf::Datatypes.Any(a)}, namespace: namespace))
      data = recv
      fields = []
      while data.is_a? Protobuf::Resultset::ColumnMetaData
        fields.push Field.new(data)
        data = recv
      end
      rows = []
      while data.is_a? Protobuf::Resultset::Row
        row = decode_row(fields, data.field)
        rows.push row
        data = recv
      end
      raise unless data.is_a? Protobuf::Resultset::FetchDone
      data = recv
      until data.is_a? Protobuf::Sql::StmtExecuteOk
        data = recv
      end
      Result.new(fields, rows)
    end

    # @param fields [Array<Field>]
    # @param row [Array<String>]
    # @return [Array<Object>] one row data
    def decode_row(fields, row)
      fields.each_with_index.map do |field, i|
        decode_data(field.type, row[i])
      end
    end

    # @param type [Integer]
    # @param data [String]
    def decode_data(type, data)
      return nil if data.empty?
      case type
      when Protobuf::Resultset::ColumnMetaData::FieldType::SINT
        decode_sint(data)
      when Protobuf::Resultset::ColumnMetaData::FieldType::UINT
        decode_uint(data)
      when Protobuf::Resultset::ColumnMetaData::FieldType::DOUBLE
        decode_double(data)
      when Protobuf::Resultset::ColumnMetaData::FieldType::FLOAT
        decode_float(data)
      when Protobuf::Resultset::ColumnMetaData::FieldType::BYTES
        decode_bytes(data)
      when Protobuf::Resultset::ColumnMetaData::FieldType::TIME
        decode_time(data)
      when Protobuf::Resultset::ColumnMetaData::FieldType::DATETIME
        decode_datetime(data)
      when Protobuf::Resultset::ColumnMetaData::FieldType::SET
        decode_set(data)
      when Protobuf::Resultset::ColumnMetaData::FieldType::ENUM
        decode_enum(data)
      when Protobuf::Resultset::ColumnMetaData::FieldType::BIT
        decode_bit(data)
      when Protobuf::Resultset::ColumnMetaData::FieldType::DECIMAL
        decode_decimal(data)
      else
        raise "unsupported type: #{type}"
      end
    end

    # @param data [String]
    # @return [Integer]
    def decode_sint(data)
      n = ::Protobuf::Varint.decode(StringIO.new(data))
      (n >> 1) ^ -(n & 1)
    end

    # @param data [String]
    # @return [Integer]
    def decode_uint(data)
      ::Protobuf::Varint.decode(StringIO.new(data))
    end

    # @param data [String]
    # @return [Float]
    def decode_double(data)
      data.unpack('E').first
    end

    # @param data [String]
    # @return [Float]
    def decode_float(data)
      data.unpack('e').first
    end

    # @param data [String]
    # @return [String]
    def decode_bytes(data)
      data.chop
    end

    # @param data [String]
    # @return [Integer] as second
    def decode_time(data)
      neg, time = data.unpack('Ca*')
      s = StringIO.new(time)
      hour = min = sec = 0
      hour = ::Protobuf::Varint.decode(s) unless s.eof?
      min = ::Protobuf::Varint.decode(s) unless s.eof?
      sec = ::Protobuf::Varint.decode(s) unless s.eof?
      time = hour * 3600 + min * 60 + sec
      neg == 0 ? time : -time
    end

    # @param data [String]
    # @return [Time] UTC
    def decode_datetime(data)
      s = StringIO.new(data)
      y = ::Protobuf::Varint.decode(s)
      m = ::Protobuf::Varint.decode(s)
      d = ::Protobuf::Varint.decode(s)
      hour = min = sec = usec = 0
      hour = ::Protobuf::Varint.decode(s) unless s.eof?
      min = ::Protobuf::Varint.decode(s) unless s.eof?
      sec = ::Protobuf::Varint.decode(s) unless s.eof?
      usec = ::Protobuf::Varint.decode(s) unless s.eof?
      Time.utc(y, m, d, hour, min, sec, usec)
    end

    # @param data [String]
    # @return [Array<String>]
    def decode_set(data)
      ret = []
      s = StringIO.new(data)
      until s.eof?
        len = ::Protobuf::Varint.decode(s)
        break if s.eof?
        ret.push s.read(len)
      end
      ret
    end

    # @param data [String]
    # @return [String]
    def decode_enum(data)
      decode_bytes(data)
    end

    # @param data [String]
    # @return [Integer]
    def decode_bit(data)
      ::Protobuf::Varint.decode(StringIO.new(data))
    end

    # @param data [String]
    # @return [BigDecimal]
    def decode_decimal(data)
      scale, n = data.unpack('CH*')
      n.sub!(/([cd])0?\z/, '')
      sign = $1
      n = "-#{n}" if sign == 'd'
      n[-scale, 0] = '.'
      BigDecimal(n)
    end

    class Auth
      # @param proto [Mysqlx::Protocol]
      def initialize(proto)
        @proto = proto
      end

      # @param user [String]
      # @param password [String]
      # @param database [String]
      def authenticate(user, password, database=nil)
        @proto.send(Protobuf::Session::AuthenticateStart.new(mech_name: mech_name))
        challenge = @proto.recv.auth_data
        scrambled = scramble_password(password, challenge)
        data = [database, user, scrambled].join("\0")
        @proto.send(Mysqlx::Protobuf::Session::AuthenticateContinue.new(auth_data: data))
        frame = @proto.recv
        unless @proto.recv.is_a? Protobuf::Session::AuthenticateOk
          raise "invalid packet received: #{recv.inspect}"
        end
      end

      # @param str1 [String]
      # @param str2 [String]
      # @return [String]
      def xor(str1, str2)
        str1.unpack('C*').zip(str2.unpack('C*')).map{|a, b| a ^ b}.pack('C*')
      end
    end

    class AuthMysql41 < Auth
      # @return [String]
      def mech_name
        'MYSQL41'
      end

      # @param password [String]
      # @param challenge [String]
      # @return [String] scrambled password
      def scramble_password(password, challenge)
        hash1 = Digest::SHA1.digest(password)
        hash2 = Digest::SHA1.digest(hash1)
        hash3 = Digest::SHA1.digest(challenge + hash2)
        '*'+xor(hash1, hash3).unpack1('H*').upcase
      end
    end

    class AuthSha256Memory < Auth
      # @return [String]
      def mech_name
        'SHA256_MEMORY'
      end

      # @param password [String]
      # @param challenge [String]
      # @return [String] scrambled password
      def scramble_password(password, challenge)
        hash1 = Digest::SHA256.digest(password)
        hash2 = Digest::SHA256.digest(hash1)
        hash3 = Digest::SHA256.digest(hash2 + challenge)
        xor(hash1, hash3).unpack1('H*').upcase
      end
    end
  end
end
