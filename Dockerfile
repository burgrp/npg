FROM node:10-slim

RUN apt-get update
RUN apt-get install git -y
RUN apt-get clean

COPY npg.sh npg.sh
CMD ./npg.sh