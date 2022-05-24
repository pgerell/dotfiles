function git_repo_select --description 'Select repository from list returned by git_repos' --argument pattern
    if test -n "$pattern"
        git_repos | fzf -0 -1 -e -q $pattern
    else
        git_repos | fzf -0 -1 -e
    end
end
