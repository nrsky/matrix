How to set up:

Install mongod:
MAC - brew install mongodb
Linux - https://docs.mongodb.com/manual/tutorial/install-mongodb-on-os-x/   

To start mongo server: 
by tutorial above or fast launch: mongod  --dbpath /path_to_your_folder

#create database rake db:create from project directory

bundle exec rspec - for tests

bundle exec cucumber - for features

rails s Puma #start the service

Assumptions
1) Not sure what for do you need passfrase in the output. 
2) Please check all TODOs,  I didn't have enaugh time to finish all I wanted. Can be done if needed
3) I've decided to choose mongodb + mongoid instead of Postgres + ActiveRecord or other relational DB.
 It supports dynamic models, we don't need transactions or joins here, so better to use non relational data. 
I was also thinking about elasticsearch, but it is a bit longer to integrate and write tests and no requirements  
for the high load were specified. 
I have not time also to create  exceptions when the zip is not valid, file can't be parsed or we have wrong format in it, 
 please see TODO comments. 
4) Please keep in mind if you need something additional to be added to the system to check how would I implement it -
 feel free to contact me.   