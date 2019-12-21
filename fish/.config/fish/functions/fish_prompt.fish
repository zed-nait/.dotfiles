function fish_prompt
  set -l is_git_repository (command git rev-parse --is-inside-work-tree 2>/dev/null)

  echo  
  echo -n (set_color blue)(prompt_pwd)
  
  if test -n "$is_git_repository"
    echo -n ' '(git_branch) [(git_status)]
  end

  echo
  echo (set_color white)'▶ '(set_color normal)
end
