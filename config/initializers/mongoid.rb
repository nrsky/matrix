Mongoid.load!(Rails.root.join("config/mongoid.yml"))
Mongoid.logger.level = Logger::INFO
Mongo::Logger.logger.level = Logger::INFO
