# Microservices

[Install VirtualBox](https://phoenixnap.com/kb/install-virtualbox-on-ubuntu)

```
sudo apt-get update
sudo apt-get install virtualbox
```

[This computer doesn't have VT-X/AMD-v enabled. Enabling it in the BIOS is mandatory](https://github.com/docker/machine/issues/4271)

* FIX: VM-->Settings--->Processor-->Enable "Virtualize Intel VT-x/EPT "...

## Docker machine

```
docker-machine create --driver=virtualbox default
```

- Check that Docker-host succesfully created

```
docker-machine ls
```

- For export variables into current shell use

```
eval $(docker-machine env)
```

## Repo structure

- [Dockerfile](Dockerfile) - description of the image
- [mongod.conf](mongod.conf) - config prepared in advance for mongodb
- [db_config](db_config) - contains variable with link to mongodb
- [start.sh](start.sh) - script for application execution

## Image build

- Now we are ready to build our image
  - Execute command
    - Dot in the end is must, it points to the path to the Docker-context
    - Flag -t defines tag for the built image
  
```
docker build -t app:latest .
```

- Check the result

```
docker images -a
```

## Start a container

- Pefect, now it is possible to run our container with command

```
docker run --name app -d --network=host app:latest
```

- Check the result

```
docker-machine ls
```

* Open a link in the browser
http://192.168.99.100:9292

## Docker hub

- Download our image into docker hub for using in the future

```
docker tag app:latest <your_dockerhub_account>/app:1.0
```

[See example](https://hub.docker.com/repository/docker/rhinock/app/general)