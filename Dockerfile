# Set the base image to use to Ubuntu
FROM ubuntu:16.04

# Set the file maintainer
MAINTAINER Ozgur Eroglu

# Set env variables used in this Dockerfile
# Local directory with project source
ENV DJANGO_PROJ ./proj_src/testprj
# Directory in container for all project files
ENV CONT_SRV /srv
# Directory in container for project source files
ENV CONT_PRJ_HOME /srv/testprj

# Update the default application repository sources list
RUN apt-get update && apt-get -y upgrade

RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update && apt-get -y upgrade

RUN apt-get install -y python3.6 python3-pip

RUN apt-get install -y python3-venv


# Create application subdirectories for media, static and logs of the project
WORKDIR $CONT_SRV
RUN mkdir media static logs

# Copy application source code
COPY $DJANGO_PROJ $CONT_PRJ_HOME

WORKDIR /srv/venv/

# Install Python dependencies
RUN python3 -mvenv /srv/venv/wbdap && ls /srv/venv/wbdap && /srv/venv/wbdap/bin/pip3 install -r $CONT_PRJ_HOME/requirements.txt
# RUN virtualenv -p python3 wbdap && ls wbdap && wbdap/bin/pip3 install -r $CONT_PRJ_HOME/requirements.txt


VOLUME ["/srv/media/", "/srv/logs/", "/srv/static/", "/srv/venv/"]



# RUN . $CONT_SRV/venv/bin/activate
# RUN source $CONT_SRV/venv/bin/activate
# RUN $CONT_SRV/venv/wbdap/bin/pip3 install -r $CONT_PRJ_HOME/requirements.txt

# Port to expose
EXPOSE 8000

# Copy entrypoint script into the image
WORKDIR $CONT_PRJ_HOME
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
