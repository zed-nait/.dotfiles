function yt-clip
    # $1: url or Youtube video id
    # $2: starting time, in seconds, or in hh:mm:ss[.xx] form
    # $3: end time, in seconds, or in hh:mm:ss[.xx] form
    # $4: file name
    set -l url $argv[1]
    set -l filename (default (yt-dlp --get-filename -f $url) $argv[4] )

    yt-dlp  --external-downloader ffmpeg --external-downloader-args "ffmpeg_i:-loglevel warning -hide_banner -stats -ss $argv[2] -to $argv[3]" -o "$filename" "$url"
end
