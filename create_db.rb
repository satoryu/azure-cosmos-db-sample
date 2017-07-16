require_relative './bootstrap'

require 'json'
connections = JSON.load(File.read(File.join(__dir__, 'connections.json')))

type = ARGV.first

connection = connections[type]['value']

context = Azure::DocumentDB::Context.new connection['DOCUMENTDB_HOST'], connection['DOCUMENTDB_KEY']
database = Azure::DocumentDB::Database.new context, RestClient
database.create "document_sample_db"

client = Mongo::Client.new(connection['MONGODB_URL'], database: 'mongo_sample_db')
client[:mongo_sample_collection].insert_one(foo: 'bar')