FROM python:alpine

RUN apk add --no-cache aria2 \
  && adduser -D aria2 \
  && mkdir -p /etc/aria2 \
  && mkdir -p /aria2down \
  && rm -rf /var/lib/apk/lists/*

RUN apk add --no-cache \
  ffmpeg \
  tzdata \
  jq  \
  exiv2  \
  bash  \
  curl  \
  perl  \
  coreutils 

RUN pip3 install yq

RUN apk add gcc musl-dev --no-cache \
  && pip install --no-cache-dir bottle pyyaml youtube_dl \
  && apk del gcc musl-dev --no-cache

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY ./youtube-dl-server/bootstrap.sh .
COPY ./youtube-dl-server/ydl_server ./ydl_server
COPY ./youtube-dl-server/youtube-dl-server.py .

RUN bash -c "apk add --no-cache wget && chmod +x ./bootstrap.sh && ./bootstrap.sh && apk del wget"

COPY ./c* ./
COPY ./init.sh .
COPY ./startServer.sh .
COPY ./live-dl .
COPY ./cookies.txt /cookies.txt
RUN chmod a+x live-dl \
  && chmod +x init.sh \
  && ./init.sh

EXPOSE 8080

VOLUME ["/youtube-dl"]

# For youtube-dl-server
ENV YOUTUBE_DL=youtube_dl

ENTRYPOINT [ "./live-dl" ]