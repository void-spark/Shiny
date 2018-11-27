#!/bin/sh
ssh pirate@black-pearl.fritz.box "mkdir -p -v ~/esp32_fw"
scp build/shiny.bin Dockerfile pirate@black-pearl.fritz.box:~/esp32_fw
ssh pirate@black-pearl.fritz.box "docker ps;cd ~/esp32_fw;docker build --rm -t nginx_esp32_fw:latest .;docker image prune -f;\
docker stop esp32_fw;docker rm esp32_fw;docker run -d --name esp32_fw --publish 8090:80 nginx_esp32_fw"
