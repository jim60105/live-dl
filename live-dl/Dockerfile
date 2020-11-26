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
	&& pip install bottle youtube-dl \
	&& apk del gcc musl-dev --no-cache

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY . /usr/src/app
COPY cookies.txt /cookies.txt
RUN chmod a+x /usr/src/app/live-dl \
	&& chmod +x /usr/src/app/init.sh

RUN /usr/src/app/init.sh

EXPOSE 8080

VOLUME ["/youtube-dl"]

ENTRYPOINT [ "./live-dl" ]