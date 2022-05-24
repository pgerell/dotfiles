function git_repos --description 'Returns list of repository names' --argument pattern
    curl -s "https://sirius.ydesign.se/gitweb/?a=project_index" | string trim
end
