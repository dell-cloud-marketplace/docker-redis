FROM ubuntu:trusty
MAINTAINER Dell Cloud Market Place <Cloud_Marketplace@dell.com>

# Set environment variable for package install
ENV DEBIAN_FRONTEND noninteractive

# Install packages
RUN apt-get update && \
    apt-get install -y redis-server pwgen && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add scripts
ADD run.sh /run.sh
ADD set_redis_password.sh /set_redis_password.sh
RUN chmod +x /*.sh

# Environment variables
ENV REDIS_MODE ""
ENV REDIS_TIMEOUT 0
ENV REDIS_PASS ""

# Expose Redis server port
EXPOSE 6379

CMD ["/run.sh"]
