# Set the base image to use to Ubuntu
FROM ubuntu:16.04

# Set the file maintainer
MAINTAINER Ozgur Eroglu

# Set env variables used in this Dockerfile
# Local directory with project source
ENV DJANGO_PROJ=./WBDAP
# Directory in container for all project files
ENV CONT_SRV=/srv
# Directory in container for project source files
ENV CONT_PRJ_HOME=/srv/WBDAP

# Update the default application repository sources list
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y python python-pip

# Create application subdirectories for media, static and logs of the project
WORKDIR $CONT_SRV
RUN mkdir media static logs
VOLUME ["$CONT_SRV/media/", "$CONT_SRV/logs/"]

# Copy application source code
COPY $DJANGO_PROJ $CONT_PRJ_HOME

# Install Python dependencies
RUN pip install -r $CONT_PRJ_HOME/requirements.txt

# Port to expose
EXPOSE 8000

# Copy entrypoint script into the image
WORKDIR $CONT_PRJ_HOME
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
