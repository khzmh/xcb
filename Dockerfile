FROM ubuntu:latest


RUN apt-get update && apt-get install -y --no-install-recommends curl git wget tar zip 

WORKDIR /xcb

COPY . /xcb/


RUN chmod +x /xcb/mine.updated.sh

CMD ["./mine.updated.sh"]
