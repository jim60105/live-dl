# live-dl on Docker
```bash
docker run --rm
    -v D:\YoutubeDownload:/youtube-dl
    -v D:\YoutubeDownload\cookies.txt:/usr/src/app/cookies.txt
    jim60105/live-dl https://www.youtube.com/watch?v=GDOQTShjTQs
```

此格式如下
```bash
docker run --rm
    -v {{影片儲存資料夾}}:/youtube-dl
    -v {{cookies file，用於登入驗證}}:/usr/src/app/cookies.txt
    jim60105/live-dl {{Youtube網址}}
```
將{{}}填入你的內容，若不需要登入就不要bind上cookies file

## 下載會員限定影片
youtube-dl支援以cookie的方式登入，可以下載會限影片
> youtube-dl的帳密功能**目前確定是壞的**，只能以cookies方式登入\
> 此cookies file包含了你的Youtube登入授權，請務必妥善保管
* 安裝瀏覧器擴充功能，以匯出Netscape HTTP Cookie File
    * Chrome: [Get cookies.txt](https://chrome.google.com/webstore/detail/get-cookiestxt/bgaddhkoddajcdgocldbbfleckgcbcid)
    * Firefox: [cookies.txt](https://addons.mozilla.org/zh-TW/firefox/addon/cookies-txt/)
* 瀏覧至Youtube網頁，登入你的帳號
* 以擴充功能匯出`youtube.com`網域的所有cookie
* 將匯出之cookie檔案重命名為`cookies.txt`
* 取代專案根目錄下的cookies.txt檔，或用於docker run時的volume bind


## Features

- URL guessing: this script will try it best to guess what you pass to it, the following URLs/URIs should all work:
  - https://www.youtube.com/channel/UC1opHUrw8rvnsadT-iGp7Cg/live
  - https://www.youtube.com/channel/UC1opHUrw8rvnsadT-iGp7Cg
  - https://www.youtube.com/watch?v=S3CAGeeMRvo
  - S3CAGeeMRvo
  - UC1opHUrw8rvnsadT-iGp7Cg
- Monitor your favorite YouTube channel and download streams when live starts
- Email/Slack notifications when stream starts or finish downloading
- Writing streamer metadata (author/channel name, description, year) via FFmpeg

## 錄影完成Callback
如果需要在下載完成後回呼，請將回呼腳本bind至`/usr/src/app/callback.sh`

### callback.sh傳入之參數:
```
__info "Calling callback function..."
local cmd=( "$CALLBACK_EXEC" "${OUTPUT_PATH}.mp4" "$BASE_DIR/" "$VIDEO_ID" "$FULLTITLE" "$UPLOADER" "$UPLOAD_DATE" )
nohup "${cmd[@]}" &>> "$OUTPUT_PATH.log" &
```
- 產出檔案的完整路徑
- 產出檔案之所在資料夾
- 影片id
- 影片標題
- 影片上傳者
- 上傳日期