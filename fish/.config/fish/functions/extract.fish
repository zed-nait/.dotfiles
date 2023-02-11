function extract
    switch $argv[1]
        case '*.tar.bz2'
            tar xvjf $argv

        case '*.tar.gz'
            tar xvzf $argv

        case '*.tar.xz'
            tar xvJf $argv

        case '*.xz'
            unxz $argv

        case '*.bz2'
            bunzip2 $argv

        case '*.gz'
            gunzip $argv

        case '*.tar'
            tar xvf $argv

        case '*.tbz2'
            tar xvjf $argv

        case '*.tgz'
            tar xvzf $argv

        case '*.Z'
            uncompress $argv

        case '*.zip'
            echo "unzip $argv"

        case '*.rar'
            unrar e $argv

        case '*'
            echo "Cannot extract $argv[1]."
    end
end
