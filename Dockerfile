# Use the official HiveMQ Docker image as the base image
FROM hivemq/hivemq-ce
# For Enterprise Edition use the following base image
# FROM hivemq/hivemq4

# Switch to root user to install packages
USER root

# Install Nginx for reverse proxy
RUN apt-get update && \
    apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/*

# Copy custom configuration files into the container
COPY config.xml /opt/hivemq/conf/config.xml
COPY nginx.conf /etc/nginx/nginx.conf

# Expose MQTT, Websocket, and clustering ports
# EXPOSE 1883 8000 7800

# Expose Nginx HTTP port
EXPOSE 80

# Ensure HiveMQ and Nginx are started
CMD service nginx start && /opt/hivemq/bin/run.sh
