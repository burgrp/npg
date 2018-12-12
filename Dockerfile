FROM node:10-slim

RUN apt-get update
RUN apt-get install -y git
#RUN apt-get install -y python
#RUN apt-get install -y make
RUN apt-get clean

COPY npg.sh npg.sh
CMD ./npg.sh