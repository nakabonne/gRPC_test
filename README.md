## SetUp
```
//①move
$ cd ../mel_exam
//②build
$ docker-compose build
//③start
$ docker-compose up -d
//④set up db
$ docker-compose run mel-exam ruby db_setup.rb
```

## Start server
```
$ docker-compose run mel-exam ruby ruby/greeter_server.rb
```

## Start client
```
$ docker-compose run mel-exam ruby ruby/greeter_client.rb
```
