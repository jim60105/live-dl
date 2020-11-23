# live-dl on Docker + 磁碟滿時自動清理錄影
> 這是從屬於 [jim60105/docker-ReverseProxy](https://github.com/jim60105/docker-ReverseProxy) 的 live-dl 方案，必須在上述伺服器運行正常後再做

此方案可以監控Youtube頻道之公開直播並錄影，在磁碟錄滿後自動刪除影片(由舊的刪起)

## 架構
WWW\
│\
nginx Server (Reverse Proxy) (SSL證書申請、Renew)\
└ live-dl (直播錄影機，提供對外WebUI)\
 　└ Jobber (Cron) (定時檢查磁碟使用率，在高於設定之百分比時，自動由舊起刪除錄影) 

## 說明
* 手動下載會儲存在主機的 `../YoutubeRecordings/` 之下
* 自動錄影會儲存在主機的 `../YoutubeRecordings/AutoRecordings` 之下
* 請參考 `*.env_sample` 建立 `*.env`
    * LETSENCRYPT_EMAIL=你的email
    * HOST=WebUI網址
    * DelPercentage=要執行刪除功能的磁碟使用百分比
* 請編輯 `config.yml` 在map處建立名稱表，**此表用於自動錄播時的資料夾建立**
    ```yml
    - name: 久遠たま
      youtube: https://www.youtube.com/channel/UCBC7vYFNQoGPupe5NxPG4Bw
    ```
* 請參考 `Auto/tama.sh` 建立要自動錄播的頻道，所有Auto下的檔案都會被執行
```sh
nohup /bin/bash ./live-dl {{Youtube URL}} &>/youtube-dl/logs/live-dl-{{Channel Name}}.$(date +%d%b%y-%H%M%S).log &
```
* 正式發佈前移除 `.env` 中的 `LETSENCRYPT_TEST=true`\
此設定為SSL測試證書\
正式版有申請次數上限，務必在測試正常、最後上線前再移除