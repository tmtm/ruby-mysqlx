# encoding: utf-8

##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf'


##
# Imports
#
require_relative 'mysqlx.pb'
require_relative 'mysqlx_expr.pb'
require_relative 'mysqlx_datatypes.pb'

module Mysqlx
  module Protobuf
    module Crud
      ::Protobuf::Optionable.inject(self) { ::Google::Protobuf::FileOptions }

      ##
      # Enum Classes
      #
      class DataModel < ::Protobuf::Enum
        define :DOCUMENT, 1
        define :TABLE, 2
      end

      class ViewAlgorithm < ::Protobuf::Enum
        define :UNDEFINED, 1
        define :MERGE, 2
        define :TEMPTABLE, 3
      end

      class ViewSqlSecurity < ::Protobuf::Enum
        define :INVOKER, 1
        define :DEFINER, 2
      end

      class ViewCheckOption < ::Protobuf::Enum
        define :LOCAL, 1
        define :CASCADED, 2
      end


      ##
      # Message Classes
      #
      class Column < ::Protobuf::Message; end
      class Projection < ::Protobuf::Message; end
      class Collection < ::Protobuf::Message; end
      class Limit < ::Protobuf::Message; end
      class Order < ::Protobuf::Message
        class Direction < ::Protobuf::Enum
          define :ASC, 1
          define :DESC, 2
        end

      end

      class UpdateOperation < ::Protobuf::Message
        class UpdateType < ::Protobuf::Enum
          define :SET, 1
          define :ITEM_REMOVE, 2
          define :ITEM_SET, 3
          define :ITEM_REPLACE, 4
          define :ITEM_MERGE, 5
          define :ARRAY_INSERT, 6
          define :ARRAY_APPEND, 7
          define :MERGE_PATCH, 8
        end

      end

      class Find < ::Protobuf::Message
        class RowLock < ::Protobuf::Enum
          define :SHARED_LOCK, 1
          define :EXCLUSIVE_LOCK, 2
        end

        class RowLockOptions < ::Protobuf::Enum
          define :NOWAIT, 1
          define :SKIP_LOCKED, 2
        end

      end

      class Insert < ::Protobuf::Message
        class TypedRow < ::Protobuf::Message; end

      end

      class Update < ::Protobuf::Message; end
      class Delete < ::Protobuf::Message; end
      class CreateView < ::Protobuf::Message; end
      class ModifyView < ::Protobuf::Message; end
      class DropView < ::Protobuf::Message; end


      ##
      # File Options
      #
      set_option :java_package, "com.mysql.cj.x.protobuf"


      ##
      # Message Fields
      #
      class Column
        optional :string, :name, 1
        optional :string, :alias, 2
        repeated ::Mysqlx::Protobuf::Expr::DocumentPathItem, :document_path, 3
      end

      class Projection
        required ::Mysqlx::Protobuf::Expr::Expr, :source, 1
        optional :string, :alias, 2
      end

      class Collection
        required :string, :name, 1
        optional :string, :schema, 2
      end

      class Limit
        required :uint64, :row_count, 1
        optional :uint64, :offset, 2
      end

      class Order
        required ::Mysqlx::Protobuf::Expr::Expr, :expr, 1
        optional ::Mysqlx::Protobuf::Crud::Order::Direction, :direction, 2, :default => ::Mysqlx::Protobuf::Crud::Order::Direction::ASC
      end

      class UpdateOperation
        required ::Mysqlx::Protobuf::Expr::ColumnIdentifier, :source, 1
        required ::Mysqlx::Protobuf::Crud::UpdateOperation::UpdateType, :operation, 2
        optional ::Mysqlx::Protobuf::Expr::Expr, :value, 3
      end

      class Find
        # Message Options
        set_option :".Mysqlx.Protobuf.client_message_id", ::Mysqlx::Protobuf::ClientMessages::Type::CRUD_FIND

        required ::Mysqlx::Protobuf::Crud::Collection, :collection, 2
        optional ::Mysqlx::Protobuf::Crud::DataModel, :data_model, 3
        repeated ::Mysqlx::Protobuf::Crud::Projection, :projection, 4
        optional ::Mysqlx::Protobuf::Expr::Expr, :criteria, 5
        repeated ::Mysqlx::Protobuf::Datatypes::Scalar, :args, 11
        optional ::Mysqlx::Protobuf::Crud::Limit, :limit, 6
        repeated ::Mysqlx::Protobuf::Crud::Order, :order, 7
        repeated ::Mysqlx::Protobuf::Expr::Expr, :grouping, 8
        optional ::Mysqlx::Protobuf::Expr::Expr, :grouping_criteria, 9
        optional ::Mysqlx::Protobuf::Crud::Find::RowLock, :locking, 12
        optional ::Mysqlx::Protobuf::Crud::Find::RowLockOptions, :locking_options, 13
      end

      class Insert
        class TypedRow
          repeated ::Mysqlx::Protobuf::Expr::Expr, :field, 1
        end

        # Message Options
        set_option :".Mysqlx.Protobuf.client_message_id", ::Mysqlx::Protobuf::ClientMessages::Type::CRUD_INSERT

        required ::Mysqlx::Protobuf::Crud::Collection, :collection, 1
        optional ::Mysqlx::Protobuf::Crud::DataModel, :data_model, 2
        repeated ::Mysqlx::Protobuf::Crud::Column, :projection, 3
        repeated ::Mysqlx::Protobuf::Crud::Insert::TypedRow, :row, 4
        repeated ::Mysqlx::Protobuf::Datatypes::Scalar, :args, 5
        optional :bool, :upsert, 6, :default => false
      end

      class Update
        # Message Options
        set_option :".Mysqlx.Protobuf.client_message_id", ::Mysqlx::Protobuf::ClientMessages::Type::CRUD_UPDATE

        required ::Mysqlx::Protobuf::Crud::Collection, :collection, 2
        optional ::Mysqlx::Protobuf::Crud::DataModel, :data_model, 3
        optional ::Mysqlx::Protobuf::Expr::Expr, :criteria, 4
        repeated ::Mysqlx::Protobuf::Datatypes::Scalar, :args, 8
        optional ::Mysqlx::Protobuf::Crud::Limit, :limit, 5
        repeated ::Mysqlx::Protobuf::Crud::Order, :order, 6
        repeated ::Mysqlx::Protobuf::Crud::UpdateOperation, :operation, 7
      end

      class Delete
        # Message Options
        set_option :".Mysqlx.Protobuf.client_message_id", ::Mysqlx::Protobuf::ClientMessages::Type::CRUD_DELETE

        required ::Mysqlx::Protobuf::Crud::Collection, :collection, 1
        optional ::Mysqlx::Protobuf::Crud::DataModel, :data_model, 2
        optional ::Mysqlx::Protobuf::Expr::Expr, :criteria, 3
        repeated ::Mysqlx::Protobuf::Datatypes::Scalar, :args, 6
        optional ::Mysqlx::Protobuf::Crud::Limit, :limit, 4
        repeated ::Mysqlx::Protobuf::Crud::Order, :order, 5
      end

      class CreateView
        # Message Options
        set_option :".Mysqlx.Protobuf.client_message_id", ::Mysqlx::Protobuf::ClientMessages::Type::CRUD_CREATE_VIEW

        required ::Mysqlx::Protobuf::Crud::Collection, :collection, 1
        optional :string, :definer, 2
        optional ::Mysqlx::Protobuf::Crud::ViewAlgorithm, :algorithm, 3, :default => ::Mysqlx::Protobuf::Crud::ViewAlgorithm::UNDEFINED
        optional ::Mysqlx::Protobuf::Crud::ViewSqlSecurity, :security, 4, :default => ::Mysqlx::Protobuf::Crud::ViewSqlSecurity::DEFINER
        optional ::Mysqlx::Protobuf::Crud::ViewCheckOption, :check, 5
        repeated :string, :column, 6
        required ::Mysqlx::Protobuf::Crud::Find, :stmt, 7
        optional :bool, :replace_existing, 8, :default => false
      end

      class ModifyView
        # Message Options
        set_option :".Mysqlx.Protobuf.client_message_id", ::Mysqlx::Protobuf::ClientMessages::Type::CRUD_MODIFY_VIEW

        required ::Mysqlx::Protobuf::Crud::Collection, :collection, 1
        optional :string, :definer, 2
        optional ::Mysqlx::Protobuf::Crud::ViewAlgorithm, :algorithm, 3
        optional ::Mysqlx::Protobuf::Crud::ViewSqlSecurity, :security, 4
        optional ::Mysqlx::Protobuf::Crud::ViewCheckOption, :check, 5
        repeated :string, :column, 6
        optional ::Mysqlx::Protobuf::Crud::Find, :stmt, 7
      end

      class DropView
        # Message Options
        set_option :".Mysqlx.Protobuf.client_message_id", ::Mysqlx::Protobuf::ClientMessages::Type::CRUD_DROP_VIEW

        required ::Mysqlx::Protobuf::Crud::Collection, :collection, 1
        optional :bool, :if_exists, 2, :default => false
      end

    end

  end

end

