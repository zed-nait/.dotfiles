function git_status -d "Display the current git status"
  set -l reset_color (set_color normal)

  set -l untracked (set_color magenta)◒
  set -l added (set_color green)✚
  set -l modified (set_color yellow)⚑
  set -l deleted (set_color red)✖
  set -l renamed (set_color blue)▴
  set -l unmerged (set_color cyan)§

  set -l prompt_order untracked added modified renamed deleted unmerged

  set -l git_status

  set -l index (command git status --short 2>/dev/null)
  set -l trimmed_index (string split \n $index | string sub --start 1 --length 2)

  for i in $trimmed_index
    if test (string match '\?\?' $i)
      set -a git_status untracked
    end

    if test (string match '*A*' $i)
      set -a git_status added
    end

    if test (string match '*M*' $i)
      set -a git_status modified
    end

    if test (string match '*R*' $i)
      set -a git_status renamed
    end

    if test (string match '*D*' $i)
      set -a git_status deleted
    end

    if test (string match '*U*' $i)
      set -a git_status unmerged
    end
  end

  set -l full_git_status

  for i in $prompt_order
    if contains $i in $git_status
      set -l status_count (echo $git_status | grep -o "$i" | wc -l)

      set -p full_git_status "$$i$reset_color:$status_count$reset_color"
    end
  end

  echo -n (string join \| $full_git_status)

end