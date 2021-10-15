# Let's start creating an image with the application.
# We will take the ubuntu distribution of version 16.04 as a basis

FROM ubuntu:16.04

# For the application to work, we need mongo and ruby
# Update the repository cache and install the required packages

RUN apt-get update
RUN apt-get install -y mongodb-server ruby-full ruby-dev build-essential git
RUN gem install bundler

# Download our application to the container

RUN git clone https://github.com/yagubern/app.git

# Copy the configuration files to the container

COPY mongod.conf /etc/mongod.conf
COPY db_config /app/db_config
COPY start.sh /start.sh

# We need to install application dependencies and configure

RUN cd /app && bundle install
RUN mkdir -p /data/db
RUN chmod 0777 /start.sh

# We start the service at the start of the container

CMD ["/start.sh"]