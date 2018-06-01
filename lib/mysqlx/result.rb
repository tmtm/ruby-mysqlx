module Mysqlx
  class Result
    attr_reader :affected_items_count
    attr_reader :generated_insert_id
    attr_reader :warning_count
    attr_reader :warnings

    alias autoincrement_value generated_insert_id

    # @param proto [Mysqlx::Protocol]
    def initialize(proto)
      @generated_insert_id = nil
      @affected_items_count = 0
      while true
        recv = proto.recv
        break if recv.is_a? Protobuf::Sql::StmtExecuteOk
        if recv.is_a? Protobuf::Notice::Frame
          info = Protocol::NoticeMessage[recv.type].decode(recv.payload)
          case info.param.to_i
          when Protobuf::Notice::SessionStateChanged::Parameter::GENERATED_INSERT_ID
            @generated_insert_id = info.value.first.to_object
          when Protobuf::Notice::SessionStateChanged::Parameter::ROWS_AFFECTED
            @affected_items_count = info.value.first.to_object
          when Protobuf::Notice::SessionStateChanged::Parameter::PRODUCED_MESSAGE
            @message = info.value.first.to_object
          else
            raise NotImplementedError, info.inspect
          end
        end
      end
    end
  end
end
