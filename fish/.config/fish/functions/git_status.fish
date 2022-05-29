function git_status
    set --local staged (
      not command git diff-index --ignore-submodules --cached --quiet HEAD -- >/dev/null 2>&1
      and echo "true"
    )

    set --local unstaged (
      not command git diff --ignore-submodules --no-ext-diff --quiet --exit-code >/dev/null 2>&1 
      and echo "true"
    )

    if test -n "$unstaged"
        echo -n "*"
    end

    if test -n "$staged"
        echo -n "+"
    end

    echo ""
end
