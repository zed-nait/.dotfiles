function git_branch
  echo -n (set_color green)(git branch 2>/dev/null | sed -n '/\* /s///p')

  if test -z (git_status)
    echo -n (set_color green) ✔
  else
    echo -n (set_color red) ✗
  end  

  set_color normal
end
