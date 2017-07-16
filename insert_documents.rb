require_relative './bootstrap'

require 'json'
connections = JSON.parse(File.read(File.join(__dir__, 'connections.json')))

type = ARGV.shift
connection = connections[type]['value']

context = Azure::DocumentDB::Context.new connection['DOCUMENTDB_HOST'], connection['DOCUMENTDB_KEY']
database = Azure::DocumentDB::Database.new context, RestClient
collections = database.collection_for_name('document_sample_db')
collection = collections.list['DocumentCollections'].find { |c| c['id'] == 'document_sample_collection' }
collection = collections.create('document_sample_collection') if collection.nil?
document = collections.document_for_rid collection['_rid']
uuid = UUID.new
10.times do |i|
    document.create uuid.generate, { number: i, foo: 'bar' }.to_json
end

client = Mongo::Client.new(connection['MONGODB_URL'], database: 'mongo_sample_db')
10.times do |i|
    client[:mongo_sample_collection].insert_one(number: i, foo: 'bar')
end