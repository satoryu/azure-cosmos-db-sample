# Azure Cosmos DB Sample

# Usage

## Prerequisites

This instruction assuems that you have

* Linux or macOS machine
* Azure CLI 2.0
* Ruby

## Setup

### Clone the repository

```
$ git clone git@github.com:satoryu/azure-cosmos-db-sample.git
$ cd azure-cosmos-db-sample
```

### Deploy Cosmos DBs

```
$ az group deployment create -g ${YOUR_RESOURCE_GROUP} --name createCosmosDBs --template-file ./template.json \
    | jq -M '.properties.outputs' \
    > ./connections.json
```

### Install ruby libraries

```
$ gem install bundler
$ bundle install
```

## Create DB

```
bundle exec ruby create_db.rb documentTypeCosmos
bundle exec ruby create_db.rb mongoTypeCosmos
```

## Insert Documents to Collections

```
bundle exec ruby insert_documents.rb documentTypeCosmos
bundle exec ruby insert_documents.rb mongoTypeCosmos
```
