function fish_prompt
    set -l last_status $status
    set -l separator (set_color normal)'»'
    set -l prompt_user (set_color blue)$USER
    set -l prompt_hostname (set_color normal)$hostname
    set -l prompt_pwd (set_color brred)(prompt_pwd)
    set -l prompt_ssh
    set -l prompt_git

    if test "$SSH_CONNECTION" != ""
        set prompt_ssh (set_color white)"["(set_color red)"SSH"(set_color white)"]"
    end

    set -l is_git_repository (command git rev-parse --is-inside-work-tree 2>/dev/null)

    if test -n $is_git_repository
        set prompt_git (set_color cyan)(git_branch)(git_status)
    end

    echo $prompt_user \
        $separator \
        "$prompt_hostname$prompt_ssh" \
        $separator \
        $prompt_pwd


    if test $last_status = 0
        set status_indicator (set_color magenta)"λ "
    else
        set status_indicator (set_color red)"λ "
    end

    echo -n $prompt_git $status_indicator
end
