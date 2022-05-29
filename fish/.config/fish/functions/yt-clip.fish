function yt-clip
    # $1: url or Youtube video id
    # $2: starting time, in seconds, or in hh:mm:ss[.xxx] form
    # $3: duration, in seconds, or in hh:mm:ss[.xxx] form
    # $4: format, as accepted by youtube-dl (default: best)
    # other args are passed directly to youtube-dl; eg, -r 40K
    set -l fmt (default $argv[4] "best")
    set -l url (youtube-dl -g -f $fmt $argv[5] $argv[1])
    set -l filename (youtube-dl --get-filename -f $fmt $argv[5] $argv[1])
    ffmpeg -loglevel warning -hide_banner -stats \
        -ss $argv[2] -i "$url" -c copy -t $argv[3] "$filename"
    printf "Saved to: %s\n" "$filename"
    # based on Reino17's and teocci's comments in https://github.com/rg3/youtube-dl/issues/4821
end
