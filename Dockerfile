FROM ubuntu:trusty
MAINTAINER Dell Cloud Market Place <Cloud_Marketplace@dell.com>

# Set environment variable for package install
ENV DEBIAN_FRONTEND noninteractive

# Install packages
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv C7917B12 && \
    echo "deb http://ppa.launchpad.net/chris-lea/redis-server/ubuntu quantal \
    main" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y redis-server=2:2.8.9-1chl1~quantal1 pwgen && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add scripts
ADD run.sh /run.sh
ADD set_redis_password.sh /set_redis_password.sh
RUN chmod +x /*.sh

# Set environment variables
ENV REDIS_MODE **None**
ENV REDIS_TIMEOUT 0

# Expose Redis server port
EXPOSE 6379

CMD ["/run.sh"]
