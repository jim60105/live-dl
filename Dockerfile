FROM python:alpine

RUN apk add --no-cache aria2 \
  && adduser -D aria2 \
  && mkdir -p /etc/aria2 \
  && mkdir -p /aria2down \
  && rm -rf /var/lib/apk/lists/*

RUN apk add --no-cache \
  ffmpeg \
  jq  \
  exiv2  \
  bash  \
  curl  \
  perl  \
  coreutils 

RUN pip3 install yq

RUN pip install --no-cache-dir youtube_dl

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY ./init.sh .
COPY ./live-dl .
COPY ./config.yml .
COPY ./callback.sh .
COPY ./cookies.txt .
RUN chmod a+x live-dl \
  && chmod +x init.sh \
  && ./init.sh

VOLUME ["/youtube-dl"]

ENTRYPOINT [ "./live-dl" ]