# Deploy Cloud Messaging GE using Docker

It is possible to deploy the Cloud Messaging GE using Docker. Here you have the steps:

Download the Docker files from the repo:

```bash
$ git clone git@github.com:atos-ari-aeon/fiware-cloud-messaging-platform.git
```

Download the Cloud Messaging GE from the repos:

```bash
$ git clone -b docker git@github.com:atos-ari-aeon/fiware-cloud-messaging-dashboard.git
$ git clone -b docker git@github.com:atos-ari-aeon/fiware-cloud-messaging-api.git
$ git clone -b docker git@github.com:atos-ari-aeon/fiware-cloud-messaging-events-manager.git
```

Edit the docker-compose.yml file. Add your ip in the field "docker_host":

```bash
mongo:
  container_name: "mongo"
  build: env/mongodb
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
  build: ./aeon-events-manager
  ports:
   - "7789:7789"
  links:
   - mongo
   - rabbitmq
 dashboard:
  container_name: "dashboard"
  build: ./aeon-dashboard
  ports:
   - "8080:8000"
 rest:
  container_name: "rest"
  build: ./aeon-api
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

Run the script file:

```bash
$ ./deploy_aeon.sh
```
