# live-dl on Docker + 磁碟滿時自動清理錄影
> 這是從屬於 [jim60105/docker-ReverseProxy](https://github.com/jim60105/docker-ReverseProxy) 的 live-dl 方案，必須在上述伺服器運行正常後再做

**請參考 [琳的備忘手札 Youtube直播錄影伺服器建置](https://blog.maki0419.com/2020/11/docker-youtube-dl-auto-recording-live-dl.html)**

本文希望建置起能永久自動運作的Youtube直播備份機\
此專案目標定位為「錄影備份」，在發生直播主事後砍檔/砍歌時，我才會到伺服器尋找備份\
是故，本專案不著重在錄影後的檔案處理，而是在磁碟滿時做自動刪檔 

## 架構
WWW\
│\
nginx Server (Reverse Proxy) (SSL證書申請、Renew)\
└ live-dl (直播錄影機，提供對外WebUI)\
 　└ Jobber (Cron) (定時檢查磁碟使用率，在高於設定之百分比時，自動由舊起刪除錄影) 

## 說明
* 錄影和下載會儲存在主機的 `../YoutubeRecordings/` 之下
* Jobber會在每日的01:00 UTC檢查磁碟使用率，並由舊檔案刪起，直到磁碟使用率降到設定值(或直到沒有檔案)

# 部屬
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
* 給*.sh執行權限 `find ./ -type f -iname "*.sh" -exec chmod +x {} \;`
* 正式發佈前移除 `.env` 中的 `LETSENCRYPT_TEST=true`\
此設定為SSL測試證書\
正式版有申請次數上限，務必在測試正常、最後上線前再移除
