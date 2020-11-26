app_defaults = {
    'YDL_FORMAT': 'bestvideo+bestaudio/best',
    'YDL_EXTRACT_AUDIO_FORMAT': None,
    'YDL_EXTRACT_AUDIO_QUALITY': '192',
    'YDL_RECODE_VIDEO_FORMAT': None,
    'YDL_OUTPUT_TEMPLATE': '/youtube-dl/%(title)s [%(id)s].%(ext)s',
    'YDL_OUTPUT_TEMPLATE_PLAYLIST': '/youtube-dl/%(playlist_title)s/%(title)s [%(id)s].%(ext)s',
    'YDL_ARCHIVE_FILE': None,
    'YDL_SERVER_HOST': '0.0.0.0',
    'YDL_SERVER_PORT': 8080,
    'YDL_CACHE_DIR': '/youtube-dl/logs/.cache',
    'YDL_DB_PATH': '/youtube-dl/logs/.ydl-metadata.db',
    'YDL_SUBTITLES_LANGUAGES': None,
    'YDL_DEBUG': False,
    # Reference: https://github.com/ytdl-org/youtube-dl/blob/master/youtube_dl/options.py
    'YDL_RAW_OPTIONS': {
        'ignoreerrors': True,
        'embedthumbnail': True,
        'addmetadata': True,
        'cookiefile': '/cookies.txt'
        },
}
