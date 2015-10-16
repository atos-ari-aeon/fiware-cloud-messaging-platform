# Deploy Cloud Messaging GE using Docker

It is possible to deploy the Cloud Messaging GE using Docker. Here you have the steps:

Download the Cloud Messaging GE from the repo:

```bash
$ git clone -b docker git@gitlab.atosresearch.eu:ari/aeon-platform.git
```

Navigate to the platform folder:

```bash
$ cd $(pwd)/aeon-platform/docker
```

Edit the docker-compose.yuml file. Add your ip in the field "docker_host":

```bash
mongo:
  container_name: "mongo"
  build: ../src/platform/env/mongodb
  ports:
  - "27017:27017"
 rabbitmq:
  image: rabbitmq
  container_name: "rabbitmq"
  ports:
   - "5672:5672"
   - "15672:15672"
 events:
  container_name: "events"
  build: ../src/platform/events-manager
  ports:
   - "7789:7789"
  links:
   - mongo
   - rabbitmq
 dashboard:
  container_name: "dashboard"
  build: ../src/platform/frontend
  ports:
   - "8080:8000"
 rest:
  container_name: "rest"
  build: ../src/platform/rest
  ports:
   - "3000:3000"
  links:
   - mongo
   - rabbitmq
   - events
   - dashboard
  extra_hosts:
   - "docker_host: <YOUR_IP>"
```

Run the docker-compose.yuml file:

```bash
$ docker-compose -p aeon up 
```