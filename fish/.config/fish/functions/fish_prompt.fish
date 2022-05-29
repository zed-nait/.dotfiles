function fish_prompt
    set -l separator (set_color white)'»'
    set -l prompt_user (set_color blue)$USER
    set -l prompt_hostname (set_color white)(prompt_hostname)
    set -l prompt_pwd (set_color red)(prompt_pwd)
    set -l prompt_ssh
    set -l prompt_git

    if test "$SSH_CONNECTION" != ""
        set ssh (set_color white)"["(set_color red)"SSH"(set_color white)"]"
    end

    set -l is_git_repository (command git rev-parse --is-inside-work-tree 2>/dev/null)

    if test -n $is_git_repository
        set prompt_git (set_color cyan)(git_branch)(git_status)
    end

    echo $prompt_user \
        $separator \
        $prompt_hostname \
        $prompt_ssh \
        $separator \
        $prompt_pwd

    echo -n $prompt_git (set_color magenta)"λ "
end
