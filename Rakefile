require "bundler/gem_tasks"
task :default => :spec

desc 'hoge'
task :prepare do
  mysql_dir = ENV['MYSQL_DIR'] or raise 'Set MYSQL_DIR environment for MySQL source directory'
  proto_path = "#{mysql_dir}/rapid/plugin/x/protocol"
  File.file?("#{proto_path}/mysqlx.proto") or raise "file not found: #{proto_path}/mysqlx.proto"
  Dir.mktmpdir do |tmpdir|
    FileUtils.cp Dir.glob("#{proto_path}/*.proto"), tmpdir
    Dir.glob("#{tmpdir}/*.proto").each do |proto|
      File.write(proto, File.read(proto).gsub(/\bMysqlx\b/, 'Mysqlx.Protobuf'))
    end
    Dir.mkdir 'lib/mysqlx/protobuf' rescue nil
    system 'protoc', '-I', tmpdir, '--ruby_out', './lib/mysqlx/protobuf', "#{tmpdir}/mysqlx.proto" or fail
    Dir.glob("lib/mysqlx/protobuf/*.pb.rb") do |rb|
      File.write(rb, File.read(rb).gsub(/require 'mysqlx/, "require_relative 'mysqlx"))
    end
  end
end
