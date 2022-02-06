## Execute these commands to start the application

1. docker-compose build
2. docker-compose run app bundle exec rake db:migrate (if fail execute it again it will work)
3. docker-compose up

   - if this error appears

   ```
   elasticsearch_1  | ERROR: [1] bootstrap checks failed. You must address the points described in the following [1] lines before starting Elasticsearch.
   elasticsearch_1  | bootstrap check failure [1] of [1]: max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]
   ```

   execute:

   ```
   wsl -d docker-desktop
   sysctl -w vm.max_map_count=262144
   exit
   ```

## Open another terminal at root path and execute these commands

1. docker-compose run app rake elastic_search:index_models
2. docker-compose run app rake sneakers:run

## Postman man Collection [link](https://www.postman.com/Bekheit/workspace/instatask)

#### Use desktop postman to be able to use the workspace

#### Add these global variables

1. URL : set it to http://localhost:3001
2. token: it is user token and it will set when user login
3. app-token: it is application token and it will set when get the application

## Note

- RabbitMQ Logic is applied on user create only
