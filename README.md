#docker-redis

This image installs a [Redis](http://redis.io/) Server, an open source, BSD licensed, advanced key-value cache and store.

## Components
The stack comprises the following components:

Name       | Version                 | Description
-----------|-------------------------|------------------------------
Redis      | latest                  | Key-value cache and store
Ubuntu     | Ubuntu Trusty           | Operating system

## Usage

### Start the Container
To start your container with:

* A named container ("redis")
* Host port 6379 mapped to container port 6379 (default Redis server port)

Do:

    sudo docker run -d -p 6379:6379 --name redis dell/redis

When the container starts, a random password will be set. To get the password, check the logs of the container by running:

    sudo docker logs redis

You will see an output like the following:

    ========================================================================
    You can now connect to this Redis server using:

      redis-cli -a 5elsT6KtjrqVtOitprnDm7M9Vgz0MGgu -h <host> -p <port>

      Please remember to change the above password as soon as possible!
    ========================================================================

In this case, `5elsT6KtjrqVtOitprnDm7M9Vgz0MGgu` is the password. You can then connect to Redis:

    redis-cli -a 5elsT6KtjrqVtOitprnDm7M9Vgz0MGgu
     
Or by explicitly specifying the host and port
    
    redis-cli -a 5elsT6KtjrqVtOitprnDm7M9Vgz0MGgu -h 127.0.0.1 -p 6379

Test your Redis deployment by setting and getting a key/value pair, as follows:
     
    set key1 "123"
    get key1

### Advanced Example 1
If you want to use a preset password instead of a random generated one, you can set the environment variable `REDIS_PASS` to a specific password when running the container:

    sudo docker run -d -p 6379:6379 -e REDIS_PASS="mypass" --name redis dell/redis

You can now test your deployment:

    redis-cli -a mypass

### Advanced Example 2
Redis facilitates a LRU cache. In order to run Redis as a cache that will delete older entries when the memory fills up, you will need to provide the following additional environment variables:

    sudo docker run -d -p 6379:6379 -e REDIS_MODE="LRU" -e REDIS_MAXMEMORY="256mb" \
    --name redis dell/redis

where `REDIS_MODE` is `LRU` and `REDIS_MAXMEMORY` is the memory limit in which
Redis will start deleting the less recently used (LRU) keys.

More info at: http://redis.io/topics/lru-cache

## Reference

### Environmental Variables

Variable        | Default  | Description
----------------|----------|-----------------------------------------------------------------------
REDIS_PASS      | *random* | Redis password
REDIS_MAXMEMORY | 256mb    | Maximum memory in LRU cache mode
REDIS_MODE      |          | If "LRU" Redis is configured as a LRU cache
REDIS_TIMEOUT   | 0        | Close the client connection if it is inactive for the specified seconds

### Image Details

Based on  [tutum/redis](https://github.com/tutumcloud/tutum-docker-redis)

Pre-built Image   | [https://registry.hub.docker.com/u/dell/redis](https://registry.hub.docker.com/u/dell/redis)
