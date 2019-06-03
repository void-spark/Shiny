@ECHO OFF
ssh pi@raspberrypi "rm -rf /tmp/esp32 ; mkdir -p -v /tmp/esp32"
scp build/shiny.bin pi@raspberrypi:/tmp/esp32
ssh pi@raspberrypi ^" ^
docker start esp_fw ^|^| docker run -d --name esp_fw -v esp_fw_data:/usr/share/nginx/html --publish 80:80 nginx:alpine ; ^
docker cp /tmp/esp32 esp_fw:/usr/share/nginx/html ; ^
rm -rf /tmp/esp32 ; ^
docker exec -w /usr/share/nginx/html/esp32 -i esp_fw sh -c 'chown -R root:root . ; ls -lah' ^"

docker run --init -it --rm efrecon/mqtt-client sh -c "pub -h raspberrypi -t '/ledstrip1/update' -m true ; sub -h raspberrypi -t '/ledstrip1/online' -C 1 -R -v"
