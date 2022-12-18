FROM ubuntu:latest

WORKDIR /torapp
RUN chmod 777 /torapp
ENV TZ=Asia/Kolkata

RUN apt update\
 && apt -y install software-properties-common\
 && add-apt-repository -y ppa:qbittorrent-team/qbittorrent-stable\
 && apt -y install curl git wget\
     python3 python3-pip\
     aria2\
     ffmpeg mediainfo unzip p7zip-full p7zip-rar\
     libcrypto++-dev libssl-dev libc-ares-dev libcurl4-openssl-dev\
     libsqlite3-dev libsodium-dev\
     libpq-dev libffi-dev\
     qbittorrent-nox

RUN curl -L https://github.com/jaskaranSM/megasdkrest/releases/download/v0.1/megasdkrest -o /usr/local/bin/megasdkrest\
 && chmod +x /usr/local/bin/megasdkrest
RUN curl https://rclone.org/install.sh | bash

COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

COPY . .

RUN chmod 777 alive.sh
RUN chmod 777 start.sh

CMD ./start.sh
